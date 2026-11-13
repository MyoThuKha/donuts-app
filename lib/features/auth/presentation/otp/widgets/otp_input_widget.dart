import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// Six OTP boxes backed by one hidden text field, so typing advances,
/// backspace goes back, a paste fills every box and the platform can
/// autofill the code from SMS.
///
/// While [busy] the field keeps its focus, so the keyboard stays up for the
/// next try, but ignores edits. When [enabled] turns back on after a lock,
/// the field takes focus again.
class OtpInputWidget extends StatefulWidget {
  const new({
    required this.code,
    required this.onChanged,
    this.enabled = true,
    this.busy = false,
    super.key,
  });

  final String code;
  final ValueChanged<String> onChanged;
  final bool enabled;

  /// A check of the code is running.
  final bool busy;

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  static const double _activeBorderWidth = 1.5;

  late final TextEditingController _controller = TextEditingController(
    text: widget.code,
  );
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(OtpInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.code != _controller.text) _controller.text = widget.code;
    // The field can take focus only once it has rebuilt as enabled.
    if (widget.enabled && !oldWidget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < AuthRules.otpLength; i++) _box(context, i),
          ],
        ),
        Positioned.fill(child: Opacity(opacity: 0, child: _field())),
      ],
    );
  }

  Widget _field() => TextField(
    controller: _controller,
    focusNode: _focus,
    enabled: widget.enabled,
    autofocus: true,
    showCursor: false,
    keyboardType: TextInputType.number,
    autofillHints: const [AutofillHints.oneTimeCode],
    inputFormatters: [
      TextInputFormatter.withFunction(
        (previous, next) => widget.busy ? previous : next,
      ),
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(AuthRules.otpLength),
    ],
    onChanged: widget.onChanged,
    decoration: const InputDecoration(
      border: InputBorder.none,
      counterText: '',
    ),
  );

  Widget _box(BuildContext context, int index) {
    final colors = context.colors;
    final digits = widget.code;
    final active = _focus.hasFocus && index == digits.length;
    return AnimatedContainer(
      duration: context.motion.cue(AppMotion.fast),
      width: AppSizes.otpBox.width,
      height: AppSizes.otpBox.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.enabled ? colors.surface : colors.disabled,
        borderRadius: BorderRadius.circular(AppRadii.field),
        border: Border.all(
          color: active ? colors.primary : colors.surface,
          width: _activeBorderWidth,
        ),
      ),
      child: Text(
        index < digits.length ? digits[index] : '',
        style: context.text.headline,
      ),
    );
  }
}
