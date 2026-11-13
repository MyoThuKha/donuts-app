import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Puts the [OfflineBanner] above a screen that runs under the status bar.
///
/// While the app is offline, a strip opens at the top with the status bar's
/// height plus the banner's, so it pushes [child] down instead of covering
/// it. [child] then sees no top padding, because the strip already clears
/// the status bar. Back online, the strip folds away.
class OfflineBannerFrame extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return BlocSelector<ConnectivityCubit, ConnectivityStatus, bool>(
      selector: (status) => status == ConnectivityStatus.offline,
      builder: (context, offline) => Column(
        children: [
          _Strip(visible: offline, topInset: topInset),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: offline,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _Strip extends StatelessWidget {
  const new({required this.visible, required this.topInset});

  final bool visible;
  final double topInset;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: AnimatedAlign(
      alignment: Alignment.topCenter,
      heightFactor: visible ? 1 : 0,
      duration: context.motion.of(AppMotion.medium),
      curve: AppMotion.standard,
      child: ColoredBox(
        color: context.colors.inkMuted,
        child: Padding(
          padding: EdgeInsets.only(top: topInset),
          child: OfflineBanner(visible: visible),
        ),
      ),
    ),
  );
}
