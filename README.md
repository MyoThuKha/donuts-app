# J'Donuts

A working slice of the J'Donuts customer app in Flutter: onboarding with fake login and registration, an offline-first Home and Product detail, and an animated Rewards screen. It runs on Android and iOS with local data only.

This README grows with the app. Sections marked "to come" fill in as each part lands.

## Versions

| Tool | Version |
|---|---|
| Flutter | 3.50.0 (stable) |
| Dart | 3.14.0 |

## Run it

```bash
flutter pub get
flutter run
```

Pick an iOS Simulator or Android emulator when asked, or pass `-d <device id>` (list them with `flutter devices`).

Check the code:

```bash
flutter analyze
flutter test
```

Run the end-to-end test (Register → Home → Product detail) on a booted simulator, emulator or attached phone. It starts the whole app with an empty in-memory database, an in-memory session and no network, so every run registers a new user and Home renders from the bundled seed:

```bash
flutter test integration_test -d <device id>
```

## Fake OTP code

To come with registration.

## Architecture and folder map

To come.

## State management

To come.

## Offline strategy

To come.

## Animations

To come.

## Known gaps

To come.

## Time spent

To come.
