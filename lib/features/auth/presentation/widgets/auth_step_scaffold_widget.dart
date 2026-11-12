import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/back_button.dart';
import 'package:donuts/features/auth/presentation/widgets/step_progress_ring_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/terms_notice_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The layout every registration and log-in step shares: back button and
/// progress ring, a title, the step's fields, then Continue and the terms.
class AuthStepScaffold extends StatelessWidget {
  const new({
    required this.title,
    required this.body,
    required this.bottom,
    required this.step,
    required this.of,
    this.subtitle,
    this.busy = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final Widget bottom;
  final int step;
  final int of;

  /// True while the step's request runs. Back is blocked so a request
  /// can't finish behind a screen the user already left.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PopScope(canPop: !busy, child: _scaffold(colors));
  }

  Widget _scaffold(DonutsColors colors) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.authTop, colors.authBottom],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.authGutter - AppSpacing.s,
            ),
            child: Column(
              children: [
                _header(),
                Expanded(child: Builder(builder: _content)),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() => Row(
    children: [
      AppBackButton(enabled: !busy),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: StepProgressRing(step: step, of: of),
      ),
    ],
  );

  Widget _content(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Text(title, style: context.text.title),
        if (subtitle case final subtitle?) ...[
          const SizedBox(height: AppSpacing.s),
          Text(subtitle, style: context.text.bodySmall),
        ],
        const SizedBox(height: AppSpacing.xxxl),
        body,
      ],
    ),
  );

  Widget _footer() => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.s,
      AppSpacing.l,
      AppSpacing.s,
      AppSpacing.l,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        bottom,
        const SizedBox(height: AppSpacing.xxl),
        const TermsNoticeWidget(),
      ],
    ),
  );
}
