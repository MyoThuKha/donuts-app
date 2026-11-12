# Offline data

The app is offline-first. Screens read only from the local Drift database, through the DAOs' `watch...()` streams. Neither the seed files nor the mock API ever reach the UI directly: both are written into the database, and the streams then emit the new rows.

## Where the data comes from

| Source | When | Data |
|---|---|---|
| `assets/seed/catalog_v1.json` | First launch, if the database has no catalog | Products, Home sections, banners, shops |
| `assets/seed/member.json` | First launch, if the database has no member data | Profile, tiers, challenges, gifts |
| `mock-api/v1/catalog.json` | Every time the app goes online (start-up and each reconnect), and on pull-to-refresh | The public catalog |

All three files use the same envelope as the API: `{data, error, meta}`. `meta.version` is the data version. The `v1` in the file and folder names is the API version, not the data version.

`CatalogImporter` writes a catalog or member file in one transaction and records its version in the `sync_state` table. An import whose version is not newer than the stored one changes nothing, so an older copy can never roll the data back. A catalog with a repeated product id, or a section that names an unknown product, is rejected before anything is written.

The member data is private, so it is only ever seeded. Refresh updates the public catalog only.

## Changing the data

- To change what a refresh delivers, edit `mock-api/v1/catalog.json` and increase `meta.version`. Without the bump, devices that already have that version ignore the change.
- To change what a fresh install starts with, edit the files in `assets/seed/`. Existing installs keep their data.
- `test/core/sync/data/seed_files_test.dart` checks that the files parse and that every section names products that exist.

## Running against a different API

The base URL comes from `--dart-define=API_BASE_URL` and must end with `/`. The default is the `main` branch on GitHub raw:

```text
https://raw.githubusercontent.com/MyoThuKha/donuts-app/main/mock-api/
```

To test another branch, point at it, for example:

```bash
flutter run --dart-define=API_BASE_URL=https://raw.githubusercontent.com/MyoThuKha/donuts-app/refs/heads/develop/mock-api/
```

To serve the files from this machine (optionally with an artificial delay):

```bash
dart run tool/mock_server.dart --port 8080 --delay-ms 0
```

- **iOS Simulator:** run with `--dart-define=API_BASE_URL=http://localhost:8080/`.
- **Android phone over USB:** run `adb reverse tcp:8080 tcp:8080` first, then use the same define. Debug builds allow plain HTTP for this. Release builds don't.

## Network handling

- Dio uses 8 s connect and receive timeouts. It retries a failed GET twice (after 500 ms, then 1 s) on connection errors, timeouts and 5xx responses, and logs requests in debug builds.
- `ConnectivityCubit` reports online only when a network interface is up and the API host answers a HEAD request within 3 s. While an interface is up but the host doesn't answer, it probes again every 15 s.
- `CatalogSyncCubit` refreshes on every change to online and ignores a refresh request while one is running. A failed refresh keeps the cached data, and the failure is in its state for the UI to show.

## Images

`AppNetworkImage` caches downloads on disk, so an image that has loaded once still shows offline. While loading, and if the download fails, it shows the bundled asset named in the data. Until the real image files are committed, those assets are missing, and the widget shows a plain coloured box (or an "image unavailable" tile when there is no asset at all).
