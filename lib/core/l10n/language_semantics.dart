import 'package:flutter/widgets.dart';

/// Tells screen readers which language [child] is in, so VoiceOver and
/// TalkBack pick the right voice.
///
/// Flutter tells the platform only the device's language. When the member
/// picks another one in Settings, Burmese on an English phone would be read
/// with the English voice without this.
///
/// [locale] is null while the app follows the device. The widget stays in
/// the tree either way, so switching language never remounts [child].
class LanguageSemantics extends StatelessWidget {
  const new({required this.locale, required this.child, super.key});

  final Locale? locale;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Semantics(container: true, localeForSubtree: locale, child: child);
}
