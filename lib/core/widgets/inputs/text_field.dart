import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// The white rounded input from the registration designs. Its border
/// animates to `primary` on focus (or `danger` on error), and the error text
/// slides in below.
class AppTextField extends StatefulWidget {
  const new({
    required this.controller,
    required this.hint,
    this.focusNode,
    this.errorText,
    this.prefixText,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final FocusNode? focusNode;
  final String? errorText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  static const double _borderWidth = 1.5;
  static const Offset _errorSlideFrom = Offset(0, -0.3);

  FocusNode? _ownFocusNode;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownFocusNode)?.removeListener(_onFocusChanged);
      _focusNode.addListener(_onFocusChanged);
    }
  }

  void _onFocusChanged() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _ownFocusNode?.dispose();
    super.dispose();
  }

  Color _borderColour(BuildContext context) {
    final colors = context.colors;
    if (widget.errorText != null) return colors.danger;
    return _focusNode.hasFocus ? colors.primary : colors.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_box(context), _error(context)],
    );
  }

  Widget _box(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: _borderColour(context)),
      duration: context.motion.cue(AppMotion.fast),
      curve: AppMotion.standard,
      builder: (context, colour, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppRadii.field),
          border: Border.all(color: colour!, width: _borderWidth),
        ),
        child: child,
      ),
      child: SizedBox(height: AppSizes.field, child: _field(context)),
    );
  }

  /// The prefix sits outside the text field so it shows even while the
  /// field is empty and unfocused, as the designs draw `+95`.
  Widget _field(BuildContext context) {
    final prefix = widget.prefixText;
    return Row(
      children: [
        if (prefix != null)
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.l),
            child: Text(
              prefix,
              style: context.text.body.copyWith(
                color: context.colors.inkSubtle,
              ),
            ),
          ),
        Expanded(child: _input(context)),
      ],
    );
  }

  Widget _input(BuildContext context) {
    final text = context.text;
    return Center(
      child: TextField(
        autofocus: widget.autofocus,
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: text.body.copyWith(color: context.colors.ink),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: text.body.copyWith(color: context.colors.inkSubtle),
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        ),
      ),
    );
  }

  Widget _error(BuildContext context) {
    final error = widget.errorText;
    return AnimatedSwitcher(
      duration: context.motion.cue(AppMotion.fast),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: _errorSlideFrom,
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: error == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              key: ValueKey(error),
              padding: const EdgeInsets.only(
                top: AppSpacing.xs,
                left: AppSpacing.xs,
              ),
              child: Text(
                error,
                style: context.text.caption.copyWith(
                  color: context.colors.danger,
                ),
              ),
            ),
    );
  }
}
