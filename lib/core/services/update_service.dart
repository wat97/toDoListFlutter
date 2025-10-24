import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import '../utils/platform_check.dart';

/// Checks for Play Store updates (Android only) and prompts the user.
Future<void> checkAndPromptUpdate(BuildContext context) async {
  if (!isAndroid) return; // No-op on non-Android platforms (including web).

  try {
    final info = await InAppUpdate.checkForUpdate();

    // If an update is available, prompt the user.
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      final immediateAllowed = info.immediateUpdateAllowed;
      final flexibleAllowed = info.flexibleUpdateAllowed;

      if (!context.mounted) return;

      // Show a dialog asking user whether to update now.
      final choice = await showDialog<String?>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Update tersedia'),
          content: const Text(
              'Versi baru tersedia di Play Store. Mau update sekarang?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop('later'),
                child: const Text('Nanti')),
            TextButton(
                onPressed: () => Navigator.of(ctx).pop('update'),
                child: const Text('Update')),
          ],
        ),
      );

      if (!context.mounted) return;

      if (choice == 'update') {
        // Prefer immediate update when allowed (forces update via Play Store UI).
        if (immediateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (flexibleAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          // After flexible update completes, we should call completeFlexibleUpdate.
          // Here we inform the user that the update will be applied after download.
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'Download update dimulai. Silakan restart aplikasi setelah selesai.'),
              action: SnackBarAction(
                label: 'Selesai',
                onPressed: () async {
                  try {
                    await InAppUpdate.completeFlexibleUpdate();
                  } catch (_) {}
                },
              ),
            ),
          );
        }
      }
    }
  } catch (e) {
    // Non-fatal: don't block app if update check fails.
    debugPrint('In-app update check failed: $e');
  }
}
