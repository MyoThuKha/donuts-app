# Launcher icons

The foreground master is generated from the supplied pink sprinkled donut using
the built-in image generation tool. Prompt: preserve the donut's identity,
sprinkles, angle and lighting; isolate it on transparency, including its hole;
center it with a small margin; no text or extra objects.

Regenerate platform assets from the repository root on macOS:

```sh
swift tool/generate_app_icons.swift
```

- Default: pink donut on pastel cream (`#FFF0DF`).
- Android 26+: adaptive foreground/background, with the donut inside the 66dp
  circular safe zone. Earlier Android versions use density-specific PNGs.
- Android 33+: a clean monochrome donut ring allows compatible launchers to
  apply wallpaper colors when themed icons are enabled.
- iOS/iPadOS: all existing iPhone/iPad sizes plus opaque 1024px default, dark
  and grayscale tinted artwork. Dark/tinted appearances require iOS 18+.
  The operating system controls the selected tint; pastel colors depend on
  the user's Home Screen settings. These are asset catalog icons, not layered
  Icon Composer artwork.

Preview files live here; native assets are in the Android resources and iOS
AppIcon catalog. No runtime dependency or app setting is required.

Validation: Android resources compiled with aapt2; iOS catalog compiled with
actool. Home Screen rendering has not been checked on physical devices.

References:
- https://developer.android.com/develop/ui/compose/system/icon_design_adaptive
- https://developer.apple.com/documentation/xcode/configuring-your-app-icon
