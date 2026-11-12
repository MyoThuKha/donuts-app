import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/sheets/placeholder_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

typedef _Provider = ({String name, String asset});

/// Google, Apple and Facebook buttons. None is wired to a real provider.
class SocialSignInRowWidget extends StatelessWidget {
  const new({super.key});

  static const double logoSize = 24;

  /// Brand names stay in English in every locale.
  static const List<_Provider> _providers = [
    (name: 'Google', asset: 'assets/logos/google.svg'),
    (name: 'Apple', asset: 'assets/logos/apple.svg'),
    (name: 'Facebook', asset: 'assets/logos/facebook_brand.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.l,
      children: [for (final p in _providers) _button(context, p)],
    );
  }

  Widget _button(BuildContext context, _Provider provider) {
    final l10n = context.l10n;
    return Semantics(
      button: true,
      label: l10n.continueWith(provider.name),
      excludeSemantics: true,
      onTap: () => _open(context, provider),
      child: InkResponse(
        onTap: () => _open(context, provider),
        radius: AppSizes.button / 2,
        child: SizedBox.square(
          dimension: AppSizes.button,
          child: Center(
            child: SvgPicture.asset(
              provider.asset,
              width: logoSize,
              height: logoSize,
            ),
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, _Provider provider) => showPlaceholderSheet(
    context,
    message: context.l10n.socialSignInUnavailable(provider.name),
  );
}
