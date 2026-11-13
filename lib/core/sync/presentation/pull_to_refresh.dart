import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_state.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// A pull-to-refresh: refreshes the catalog, or waits for the refresh
/// already running, and reports a failure in a snackbar. Screens keep
/// showing the saved data. Only a pull reports failures: background
/// refreshes stay silent.
Future<void> refreshCatalogFromPull(BuildContext context) async {
  final sync = context.read<CatalogSyncCubit>();
  final messenger = ScaffoldMessenger.of(context);
  final failedMessage = context.l10n.homeRefreshFailed;
  if (sync.state.status == CatalogSyncStatus.syncing) {
    await sync.stream.firstWhere(
      (state) => state.status != CatalogSyncStatus.syncing,
    );
  } else {
    await sync.refresh();
  }
  if (sync.state.status != CatalogSyncStatus.failed) return;
  messenger.showMessage(failedMessage, tone: AppSnackBarTone.error);
}
