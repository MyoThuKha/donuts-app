# J'Donuts

A working slice of the J'Donuts customer app in Flutter. It covers onboarding with a fake login and registration, an offline-first Home and Product detail, and an animated Rewards screen. It runs on Android and iOS, in English and Burmese, with local data only.

## At a glance

| | |
|---|---|
| OTP code | **`123456`** for every number |
| Sample phone number | `09254135592`, typed after the fixed +95 |
| Download | [Latest release](https://github.com/MyoThuKha/donuts-app/releases/latest): signed APK and zipped iOS Simulator app |
| Flutter / Dart | 3.50.0 (stable) / 3.14.0 |
| App version | 1.0.0+2 |
| Languages | English, Burmese (pick one in Settings) |
| Back end | None. Data is bundled JSON plus an optional mock API |

**Contents.** [Run it](#run-it) · [Try the flow](#try-the-flow) · [Sign-up rules](#sign-up-rules) · [Architecture](#architecture-and-folder-map) · [State management](#state-management) · [Offline strategy](#offline-strategy) · [Animations](#animations) · [Tests and CI](#tests-and-ci) · [Known gaps](#known-gaps) · [Time spent](#time-spent)

## Run it

```bash
flutter pub get
```

```bash
flutter run
```

Pick an iOS Simulator or Android emulator when asked, or pass `-d <device id>` (`flutter devices` lists them). Generated code (Drift, freezed, json_serializable and l10n) is committed, so a clean clone needs no `build_runner` step.

### Commands

| To | Run |
|---|---|
| Analyze | `flutter analyze` |
| Run unit and widget tests | `flutter test` |
| Run the end-to-end test | `flutter test integration_test -d <device id>` |
| Build the release APK | `flutter build apk --release` |
| Build the iOS Simulator app | `flutter build ios --simulator` |
| Serve the mock API locally | `dart run tool/mock_server.dart --port 8080` |

The end-to-end tests need a booted simulator, emulator or attached phone. Each starts the whole app with an empty in-memory database, an in-memory session and no network, so every run registers a new user and Home renders from the bundled seed.

### Builds

| Build | Lands in | Notes |
|---|---|---|
| APK | `build/app/outputs/flutter-apk/app-release.apk` | Without `android/key.properties` it is signed with the debug key and installs on any device |
| iOS Simulator app | `build/ios/iphonesimulator/Runner.app` | Debug mode, the only mode Flutter builds for simulators |

To hand over the simulator app, zip it with `ditto -c -k --keepParent build/ios/iphonesimulator/Runner.app Runner.zip`. To install it, unzip it and drag `Runner.app` onto a booted simulator. Every [GitHub release](https://github.com/MyoThuKha/donuts-app/releases) already has both files attached.

### Mock API

The app needs no server. On first launch it loads its data from JSON bundled in the app. Once online, it refreshes the catalog from the mock API, which by default is the `mock-api/` folder of this repository's `main` branch on GitHub. To use a local copy, start the mock server from the table above, then:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080/
```

On an Android phone over USB, run `adb reverse tcp:8080 tcp:8080` first. [docs/offline-data.md](docs/offline-data.md) has the details.

## Try the flow

1. **Register.** On Onboarding, tap Let's get started. Enter `09254135592`, then the code `123456`, a first name and a date of birth. Welcome leads to Home.
2. **Log out.** Open the Settings tab, tap Log out and confirm.
3. **Log in.** Tap Log in on Onboarding, enter the same number and `123456`. It goes straight to Home.
4. **Browse.** Tap any product tile to open Product detail, then switch to the Reward tab.
5. **Cart.** Add a donut from Product detail, then open Settings and tap the cart tag at the top right. Plus and minus change a quantity, and minus at 1 is a trash button that deletes the item. The total at the bottom follows. Log out empties the cart.
6. **Go offline.** Turn on airplane mode and repeat. Home, Product detail and Rewards still render from the local database, images included.

The session survives a relaunch. Explore and Wallet in the bottom nav are placeholder tabs.

## Sign-up rules

Validators are pure functions in `lib/features/auth/domain/validators/`, and the limits are named constants in `auth_rules.dart`.

| Field | Rule | When it fails |
|---|---|---|
| Phone | After +95, spaces, dashes and one leading 0 are dropped. The rest is 9 followed by 7 to 9 digits, so `09254135592` is stored as `+959254135592` | Continue stays off. The message shows once the field loses focus |
| OTP | 6 digits. Only `123456` passes | The boxes shake and clear. 3 wrong codes lock entry until Resend |
| Resend | Counts down from 5:00 and restarts when tapped | |
| First name | Required, 1 to 50 characters after trimming. Letters and spaces, Myanmar script included, no digits | Inline message |
| Last name | Optional, same characters as the first name | Inline message |
| Date of birth | A real date, not in the future, age 13 to 120 | The date wheel offers only dates that pass, so the inline message is a backstop |

A number registers once. Logging in with an unregistered number offers a link to register, and registering a known number offers a link to log in. Either link keeps the typed number.

## Architecture and folder map

The code is feature-first. Each feature has `data`, `domain` and `presentation` layers, and the domain layer imports nothing from Flutter or Dio. `test/features/auth/domain/domain_purity_test.dart` fails if it does.

```text
lib/
├── main.dart            # configureDependencies(), bootstrap(), runApp
├── app/                 # wires the features together
│   ├── di/              # one get_it module per feature, plus core and sync
│   ├── router/          # go_router: auth guard, sign-up and log-in steps, /product/:id, /cart
│   └── shell/           # bottom nav over a StatefulShellRoute
├── core/                # shared code; never imports a feature
│   ├── database/        # Drift: tables, DAOs, schema v5 with step-by-step migrations
│   ├── network/         # Dio with timeouts, retry and logging; connectivity + reachability
│   ├── sync/            # seeding from bundled JSON and refreshing from the mock API
│   ├── result/          # Result<T> and the typed AppFailure classes
│   ├── state/           # SectionState and the stream watcher shared by screens
│   ├── storage/         # session and language in flutter_secure_storage, cleared on a new install
│   ├── l10n/            # ARB files (English, Burmese), language picker
│   ├── motion/          # every duration and curve, and Reduce Motion handling
│   ├── theme/           # colour, type, spacing and radius tokens
│   └── widgets/         # buttons, inputs, images, sheets, skeletons, state views
└── features/
    ├── auth/            # onboarding, phone, OTP, name, date of birth, welcome, session
    ├── cart/            # the persistent cart, its screen and the Settings cart tag
    ├── home/            # member panel, banners, product rows, nearby shops
    ├── product/         # product detail
    ├── rewards/         # tier ladder, points ring, challenges and gifts
    └── settings/        # member header with the cart tag, language, log out
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

There is no `datasources/` folder inside a feature, on purpose. Several features read the same tables, so the data sources are shared in `core`, and each repository takes the ones it needs:

| Data source | Where | Used by |
|---|---|---|
| Local database | Drift DAOs in `lib/core/database/daos/` | Every repository, such as `HomeRepositoryImpl(CatalogDao)` |
| Remote API and bundled seed | `CatalogRemoteDataSource` and `SeedSource` in `lib/core/sync/data/` | Only the catalog sync, which writes into the database |
| Session | `SessionStore` in `lib/core/storage/` | `FakeAuthRepository` |

No feature repository talks to the network. Screens read the database, and the sync only refreshes it.

These rules hold everywhere:

- **Errors are values.** Repositories catch exceptions and return `Result<T>` with a typed `AppFailure`. Their database streams go through `guarded()`, which turns an exception into the same `AppFailure` as an error event. Nothing above a repository sees an exception.
- **Auth can be swapped.** `AuthRepository` is an interface with `FakeAuthRepository` behind it. The fake waits about a second and keeps users in the local database. A real API client can replace it in `lib/app/di/auth_module.dart` without touching any screen.
- **Styles come from tokens.** Colours, type, spacing and motion live in `lib/core/theme/` and `lib/core/motion/`. Feature code holds no colour values or text-style overrides.
- **Strings come from ARB files.** Every string is in `lib/core/l10n/arb/`. English is the template and Burmese (`my`) is complete.

## State management

The app uses [flutter_bloc](https://pub.dev/packages/flutter_bloc) Cubits, with [get_it](https://pub.dev/packages/get_it) for dependency injection. The brief allows BLoC or Riverpod. Cubits fit here for three reasons:

- Each screen's state is an explicit immutable class, so its loading, ready, empty and failed cases sit in one place, and `bloc_test` tests every transition.
- Most screens follow a stream from the database. A Cubit subscribes once and re-emits, with no event classes for the simple cases.
- get_it keeps object creation out of widgets. Each feature registers its repositories, use cases and cubits in its own module under `lib/app/di/`, and tests swap any of them through `configureDependencies(...)`.

| Cubit | Scope | Holds |
|---|---|---|
| `SessionCubit` | App | Signed in or out. Drives the router's auth guard |
| `ConnectivityCubit` | App | Online or offline, from the network interface and a reachability check |
| `CatalogSyncCubit` | App | Background refresh of the catalog |
| `SeedCubit` | App | First-launch seeding, with Try again on failure |
| `LanguageCubit` | App | The picked language, or the device's |
| Screen cubits | One screen | Created per screen from get_it factories |

## Offline strategy

The local Drift database is the single source of truth. Screens read only from it, through `watch...()` streams, so a screen never knows whether its data came from the seed or the network.

1. **First launch.** `bootstrap()` loads `assets/seed/catalog_v1.json` and `assets/seed/member.json` into the database before the first frame. Every image they name is bundled under `assets/seed/images/`, so a first launch in airplane mode shows the full app, images included. If seeding fails, Home says so and offers Try again.
2. **Going online.** `ConnectivityCubit` reports online only when a network interface is up and the API host answers a HEAD request. On every change to online, and on pull-to-refresh, `CatalogSyncCubit` fetches `mock-api/v1/catalog.json` (a versioned `{data, error, meta}` envelope) and imports it in one transaction. An older or equal version changes nothing, so stale data can't roll the database back.
3. **Images.** Downloads are cached on disk. While one loads, or if it fails, the bundled copy shows instead.
4. **Offline.** A small banner opens at the top of Home, Product detail and Rewards and pushes the screen down. Home, Product detail, Rewards and Settings all keep working from the database.

Home, Rewards and Settings read the same member record, so their points and tier always agree. Member data is only ever seeded, never refreshed. [docs/offline-data.md](docs/offline-data.md) covers versioning, image URLs and how to change the data.

## Animations

All durations and curves are named constants in `lib/core/motion/app_motion.dart`. Every animation reads them through `context.motion`, which skips decorative motion and shortens state cues when Android's "Remove animations" or iOS's "Reduce Motion" is on. All motion uses Flutter's own APIs, with no Lottie or Rive. The points ring, the tier line and the coffee arc are `CustomPainter`s. The donut challenge colours in through a `CustomClipper` over its photo, because the photo loads through the shared image widget with its cache and bundled fallback.

| Where | What moves |
|---|---|
| Onboarding | Donut photos drift in, then the title and buttons enter staggered |
| Sign-up steps | Shared-axis transition between steps. The step ring fills 25%, 50%, 75%, 100% and turns into a check |
| Inputs | Focus and error states animate. The OTP boxes shake on a wrong code |
| Buttons | Grow while held and spring back. Continue morphs into a loading circle |
| Welcome | Donut tiles slide in staggered, then the title fades up |
| Home | Skeleton shimmer while loading, staggered sections, an auto-playing banner carousel, a ring round the avatar that sweeps to the next tier, and a spinning donut on pull-to-refresh |
| Product detail | The product image flies in from its tile. The quantity rolls to its new value |
| Rewards | See below |
| Bottom nav | The active pill slides and stretches between tabs |
| Sheets | Open and close on a spring |

On Rewards:

- The points ring sweeps while the total counts up to 680,000.
- Silver, Gold and Platinum pop in order, and the line to the next tier fills.
- A blue pill slides between the Eat more earn more and Gift tabs.
- Challenge cards enter staggered, and their art fills: the donut by quarters, the coffee arc to 9/12.
- A complete Earn button pulses.
- The Rewards badge pops in.

## Tests and CI

`flutter test` runs about 690 tests. The folders under `test/` mirror `lib/`.

| Kind | Covers |
|---|---|
| Unit | Every validator rule, every use case, the repositories, the cubits, the sync and import logic, and the Drift migrations from each schema version |
| Widget | Every screen's loading, empty, error and ready states, sign-up and log-in validation, double taps, Reduce Motion, and every screen at 1.3x text on a 4.7-inch phone |
| Integration | `integration_test/register_to_product_detail_test.dart`: register, reach Home, open a product. `integration_test/register_to_cart_test.dart`: add to the cart, step and delete, then log out and back in to an empty cart. Both run on a device |

| Workflow | Runs on | Does |
|---|---|---|
| `.github/workflows/ci.yml` | Every push and pull request | Checks formatting, runs `flutter analyze` and `flutter test` |
| `.github/workflows/release.yml` | A `v*` tag on `main` | Runs the analyzer and tests once, builds a signed APK on Linux and a zipped iOS Simulator app on macOS, then publishes both on one GitHub release |

The tag sets the version, so `v1.0.0+1` builds version 1.0.0 with build number 1.

## Known gaps

Not built:

- There is no back end. Sign-in is the fake repository, and the catalog comes from static JSON.
- Google, Apple, Facebook, Terms of Use and Privacy Policy open a placeholder sheet. Explore and Wallet are placeholder tabs.
- Redeem on a gift says it's coming soon, as do See all, Explore now and Order online on Home.
- The cart has no checkout. Its count shows only on the Settings tag.

Different from the brief:

- The OTP step verifies on its own once the sixth digit is in, so it has no Continue button.
- After three wrong codes, Resend is available at once rather than after the countdown.
- Earn adds a completed challenge's points to the member's total in the local database. The brief asks for no action.

Limits:

- The member record is seeded only. A refresh updates the public catalog, not the member's points.
- One product exists only on the server (`p_toasted_coconut`), so it has no bundled image and shows a plain box until its photo has downloaded once.
- Android release builds block plain HTTP, so they can't reach the local mock server and use the GitHub-hosted mock API instead.
- The cart table has no user column, so log out empties it rather than keeping one cart per account.
- The integration tests need a device, so CI doesn't run them.
- No profile-mode frame timings are recorded in this repository.

## Time spent

About two working days, 12 and 13 November 2026.
