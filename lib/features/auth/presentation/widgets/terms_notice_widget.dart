import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/sheets/placeholder_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

/// "By continuing, you acknowledge…" with Terms of Use and Privacy Policy
/// links. The links open a placeholder sheet.
class TermsNoticeWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<TermsNoticeWidget> createState() => _TermsNoticeWidgetState();
}

class _TermsNoticeWidgetState extends State<TermsNoticeWidget> {
  late final TapGestureRecognizer _terms = TapGestureRecognizer()
    ..onTap = () => _open(context.l10n.termsOfUse);
  late final TapGestureRecognizer _privacy = TapGestureRecognizer()
    ..onTap = () => _open(context.l10n.privacyPolicy);

  void _open(String document) => showPlaceholderSheet(
    context,
    message: context.l10n.documentUnavailable(document),
  );

  @override
  void dispose() {
    _terms.dispose();
    _privacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = context.text.caption;
    final link = style.copyWith(color: context.colors.accent);
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: '${l10n.termsPrefix} '),
          TextSpan(text: l10n.termsOfUse, style: link, recognizer: _terms),
          TextSpan(text: ' ${l10n.and} '),
          TextSpan(text: l10n.privacyPolicy, style: link, recognizer: _privacy),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
