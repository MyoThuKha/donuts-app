import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// Looks like `AppTextField` but takes no typing. A tap calls [onTap],
/// which opens a picker, and the field shows the [value] it returned.
class AppPickerField extends StatelessWidget {
  const new({
    required this.hint,
    required this.onTap,
    this.value,
    this.errorText,
    super.key,
  });

  /// Shown in place of [value] until one is picked.
  final String hint;
  final String? value;
  final String? errorText;
  final VoidCallback onTap;

  static const double _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final value = this.value;
    final error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: hint,
          value: value,
          excludeSemantics: true,
          child: Material(
            color: colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.field),
              side: BorderSide(
                color: error == null ? colors.surface : colors.danger,
                width: _borderWidth,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: AppSizes.field,
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: Text(
                  value ?? hint,
                  style: text.body.copyWith(
                    color: value == null ? colors.inkSubtle : colors.ink,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
              left: AppSpacing.xs,
            ),
            child: Text(
              error,
              style: text.caption.copyWith(color: colors.danger),
            ),
          ),
      ],
    );
  }
}
