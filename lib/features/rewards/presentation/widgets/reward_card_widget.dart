import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/cards/art_card.dart';
import 'package:material_ui/material_ui.dart';

/// The challenge and gift card, which is the shared [ArtCard].
typedef RewardCard = ArtCard;

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
