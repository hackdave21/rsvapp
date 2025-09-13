import 'package:flutter/material.dart';
import 'package:rvsapp/presentation/themes/app_themes.dart';
import 'package:rvsapp/presentation/themes/text_styles.dart';

class CustomSnackbar {
  // Snackbar de succès
  static void showSuccess(BuildContext context, String message, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.successColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
    );
  }

  // Snackbar d'erreur
  static void showError(BuildContext context, String message, {int duration = 4}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: AppTheme.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.errorColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
    );
  }

  // Snackbar d'information
  static void showInfo(BuildContext context, String message, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: AppTheme.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
    );
  }

  // Snackbar d'avertissement
  static void showWarning(BuildContext context, String message, {int duration = 4}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning_amber, color: AppTheme.grey900, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.grey900),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.warningColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
      ),
    );
  }
}