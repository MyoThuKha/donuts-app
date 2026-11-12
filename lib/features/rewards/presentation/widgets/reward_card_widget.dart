import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// The white card shared by challenges and gifts: [art] on the left, then
/// the [title] above [details].
class RewardCard extends StatelessWidget {
  const new({
    required this.art,
    required this.title,
    required this.details,
    super.key,
  });

  final Widget art;
  final String title;
  final List<Widget> details;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Row(
          spacing: AppSpacing.l,
          children: [
            SizedBox.square(dimension: RewardsDimens.cardArt, child: art),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.s,
                children: [
                  Text(title, style: context.text.sectionTitle),
                  ...details,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The card's button with its points value beside it.
class RewardCardAction extends StatelessWidget {
  const new({required this.button, required this.points, super.key});

  final Widget button;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.m,
      children: [
        button,
        Flexible(child: Text(points, style: context.text.body)),
      ],
    );
  }
}
