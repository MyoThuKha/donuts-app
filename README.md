# J'Donuts

A working slice of the J'Donuts customer app in Flutter. It covers onboarding with a fake login and registration, an offline-first Home and Product detail, and an animated Rewards screen. It runs on Android and iOS, in English and Burmese, with local data only.

## Versions

| Tool | Version |
|---|---|
| Flutter | 3.50.0 (stable) |
| Dart | 3.14.0 |
| App | 1.0.0+1 |

## Run it

```bash
flutter pub get
flutter run
```

Pick an iOS Simulator or Android emulator when asked, or pass `-d <device id>` (list them with `flutter devices`). Generated code (Drift, freezed, json_serializable and l10n output) is committed, so a clean clone needs no `build_runner` step.

The app needs no server. On first launch it loads its data from JSON bundled in the app. When it has a network connection, it also refreshes the catalog from the mock API, which by default is the `mock-api/` folder of this repository's `main` branch on GitHub. To serve that folder from your own machine instead:

```bash
dart run tool/mock_server.dart --port 8080
```

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080/
```

On an Android phone over USB, run `adb reverse tcp:8080 tcp:8080` first. [docs/offline-data.md](docs/offline-data.md) has the details.

### Check the code

```bash
flutter analyze
flutter test
```

The end-to-end test (register, Home, Product detail) needs a booted simulator, emulator or attached phone. It starts the whole app with an empty in-memory database, an in-memory session and no network, so every run registers a new user and Home renders from the bundled seed:

```bash
flutter test integration_test -d <device id>
```

### Build the deliverables

```bash
flutter build apk --release
```

```bash
flutter build ios --simulator
```

The APK lands in `build/app/outputs/flutter-apk/app-release.apk`. Without `android/key.properties` it is signed with the debug key, so it installs on any device. The iOS Simulator app lands in `build/ios/iphonesimulator/Runner.app`. Flutter builds simulator apps in debug mode only. Zip it with `ditto -c -k --keepParent build/ios/iphonesimulator/Runner.app Runner.zip`, and to install it, unzip it and drag `Runner.app` onto a booted simulator.

Each GitHub release already has both files attached. The end of [Tests](#tests) explains the release workflow.

## Fake OTP code

The code is **123456** for every number. Anything else is wrong: the boxes shake and clear, and three wrong codes lock entry until Resend. Resend counts down from 5:00.

Phone numbers are Myanmar numbers after the fixed +95, such as `09254135592`. Spaces, dashes and one leading 0 are dropped, so that number is stored as `+959254135592`.

A number registers once. Logging in with a number that hasn't registered shows a link to register, and registering a known number shows a link to log in.

## Architecture and folder map

The code is feature-first. Each feature has `data`, `domain` and `presentation` layers, and the domain layer imports nothing from Flutter or Dio. A test (`test/features/auth/domain/domain_purity_test.dart`) fails the build if it does.

```text
lib/
├── main.dart            # configureDependencies(), bootstrap(), runApp
├── app/                 # wires the features together
│   ├── di/              # one get_it module per feature, plus core and sync
│   ├── router/          # go_router: auth guard, sign-up and log-in steps, /product/:id
│   └── shell/           # bottom nav over a StatefulShellRoute
├── core/                # shared code; never imports a feature
│   ├── database/        # Drift: tables, DAOs, schema v5 with step-by-step migrations
│   ├── network/         # Dio with timeouts, retry and logging; connectivity + reachability
│   ├── sync/            # seeding from bundled JSON and refreshing from the mock API
│   ├── result/          # Result<T> and the typed AppFailure classes
│   ├── state/           # SectionState and the stream watcher shared by screens
│   ├── storage/         # session in flutter_secure_storage
│   ├── l10n/            # ARB files (English, Burmese), language picker
│   ├── motion/          # every duration and curve, and Reduce Motion handling
│   ├── theme/           # colour, type, spacing and radius tokens
│   └── widgets/         # buttons, inputs, images, sheets, skeletons, state views
└── features/
    ├── auth/            # onboarding, phone, OTP, name, date of birth, welcome, session
    ├── home/            # member panel, banners, product rows, nearby shops
    ├── product/         # product detail and add to cart
    ├── rewards/         # tier ladder, points ring, challenges and gifts
    └── settings/        # member header, language, log out
```

Inside a feature:

```text
features/home/
├── data/           # repository implementations and Drift row mappers
├── domain/         # value objects, repository interfaces, use cases
└── presentation/
    ├── blocs/      # cubits and their states
    ├── views/      # sections of a screen
    ├── items/      # one entry in a list, such as a product tile
    ├── widgets/    # small pieces used by views and items
    └── home_screen.dart
```

The rules that hold everywhere:

- Repositories catch exceptions and return `Result<T>` with a typed `AppFailure`. Their database streams go through `guarded()`, which turns an exception into the same `AppFailure` as an error event. Nothing above a repository sees an exception, and no error is dropped silently.
- `AuthRepository` is an interface with `FakeAuthRepository` behind it. The fake waits about a second and keeps users in the local database, and a real API client can replace it in `lib/app/di/auth_module.dart` without touching any screen.
- Validators are pure functions in `features/auth/domain/validators/`, each with unit tests.
- Colours, type, spacing and motion come from tokens in `lib/core/theme/` and `lib/core/motion/`. Feature code holds no colour values or text-style overrides.
- Every string is in `lib/core/l10n/arb/`. English is the template, and Burmese (`my`) is complete. The language can be picked in Settings.

## State management

The app uses [flutter_bloc](https://pub.dev/packages/flutter_bloc) Cubits, with [get_it](https://pub.dev/packages/get_it) for dependency injection. The brief allows BLoC or Riverpod. Cubits fit here for three reasons:

- Each screen's state is an explicit immutable class, so its loading, ready, empty and failed cases are visible in one place, and `bloc_test` tests every transition.
- Most screens follow a stream from the database. A Cubit subscribes once and re-emits, with no event classes for the simple cases.
- get_it keeps object creation out of widgets. Each feature registers its repositories, use cases and cubits in its own module under `lib/app/di/`, and tests swap any of them through `configureDependencies(...)`.

App-wide cubits live above the router: `SessionCubit` (signed in or out, which drives the auth guard), `ConnectivityCubit`, `CatalogSyncCubit`, `SeedCubit` and `LanguageCubit`. Screen cubits are created per screen from get_it factories.

## Offline strategy

The local Drift database is the single source of truth. Screens read only from it, through `watch...()` streams, so a screen never knows whether its data came from the seed or the network.

1. **First launch.** `bootstrap()` loads `assets/seed/catalog_v1.json` and `assets/seed/member.json` into the database before the first frame. Every image they name is bundled under `assets/seed/images/`, so a first launch in airplane mode shows the full app, images included. If seeding fails, Home says so and offers Try again.
2. **Going online.** `ConnectivityCubit` reports online only when a network interface is up and the API host answers a HEAD request. On every change to online, and on pull-to-refresh, `CatalogSyncCubit` fetches `mock-api/v1/catalog.json` (a versioned `{data, error, meta}` envelope) and imports it in one transaction. An older or equal version changes nothing, so stale data can't roll the database back.
3. **Images.** Downloads are cached on disk. While one loads, or if it fails, the bundled copy shows instead.
4. **Offline.** A small banner shows at the top of Home. Everything else works from the database: Home, Product detail, Rewards and Settings.

Home, Rewards and Settings read the same member record, so their points and tier always agree. Member data is only ever seeded, never refreshed. [docs/offline-data.md](docs/offline-data.md) covers versioning, image URLs and how to change the data.

## Animations

All durations and curves are named constants in `lib/core/motion/app_motion.dart`. Every animation reads them through `context.motion`, which skips decorative motion and shortens state cues when Android's "Remove animations" or iOS's "Reduce Motion" is on.

| Where | What moves |
|---|---|
| Onboarding | Donut photos drift in, then the title and buttons enter staggered |
| Sign-up steps | Shared-axis transition between steps; the step ring fills 25%, 50%, 75%, 100% and turns into a check |
| Inputs | Focus and error states animate; the OTP boxes shake on a wrong code |
| Buttons | Grow while held and spring back; Continue morphs into a loading circle |
| Welcome | Donut tiles slide in staggered, then the title fades up |
| Home | Skeleton shimmer while loading, sections enter staggered, the banner carousel auto-plays, a ring round the avatar sweeps to the next tier, and pull-to-refresh spins a donut |
| Product detail | Hero flight of the product image from its tile; the quantity rolls to its new value |
| Rewards | The points ring sweeps while the total counts up; Silver, Gold and Platinum pop in order and the line to the next tier fills; a blue pill slides between the tabs; challenge cards enter staggered and their art fills (donut by quarters, coffee arc to 9/12); a complete Earn pulses; the Rewards badge pops in |
| Bottom nav | The active pill slides and stretches between tabs |
| Sheets | Open and close on a spring |

All motion uses Flutter's own APIs and `CustomPainter`, with no Lottie or Rive.

## Tests

`flutter test` runs about 600 tests. The folders under `test/` mirror `lib/`.

- **Unit:** every validator rule, every use case, the repositories, the cubits, the sync and import logic, and the Drift migrations from each schema version.
- **Widget:** every screen's loading, empty, error and ready states; sign-up and log-in validation; double taps; Reduce Motion; and every screen at 1.3x text on a 4.7-inch phone.
- **Integration:** `integration_test/register_to_product_detail_test.dart`, on a device.

CI (`.github/workflows/ci.yml`) checks formatting, runs `flutter analyze` and runs `flutter test` on every push and pull request. A `v*` tag on `main` runs `.github/workflows/release.yml`. It runs the analyzer and the tests once, builds a signed release APK on Linux and a zipped iOS Simulator app on macOS, then publishes both on one GitHub release. The tag sets the version, so `v1.0.0+1` builds version 1.0.0 with build number 1.

## Known gaps

- There is no back end. Sign-in is the fake repository above, and the catalog comes from static JSON.
- Google, Apple, Facebook, Terms of Use and Privacy Policy open a placeholder sheet. Explore and Wallet in the bottom nav are placeholder tabs.
- Earn adds a completed challenge's points to the member's total in the local database. Redeem on a gift says it's coming soon, as do See all, Explore now and Order online on Home.
- Add to cart stores the item in the local database, but there is no cart screen or cart badge yet.
- The OTP step verifies on its own once the sixth digit is in, so it has no Continue button. After three wrong codes, Resend is available at once rather than after the countdown.
- The member record is seeded only. A refresh updates the public catalog, not the member's points.
- One product exists only on the server (`p_toasted_coconut`), so it has no bundled image and shows a plain box until its photo has downloaded once.
- Android release builds block plain HTTP, so they can't reach the local mock server and use the GitHub-hosted mock API instead.
- The integration test needs a device, so CI doesn't run it.
- No profile-mode frame timings are recorded in this repository.

## Time spent

About two working days, 12 and 13 November 2026.
