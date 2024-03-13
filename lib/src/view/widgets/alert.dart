import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/enums/alert_type.dart';

class Alert {
  static void dialog(BuildContext context, AlertType alertType, String message, {VoidCallback? onPress}) {
    String title;
    String okButton;
    String? cancelButton;

    switch (alertType) {
      case AlertType.error:
        title = AppLocalizations.of(context)!.error;
        okButton = AppLocalizations.of(context)!.ok;
        break;
      case AlertType.warning:
        title = AppLocalizations.of(context)!.confirmation;
        okButton = AppLocalizations.of(context)!.confirm;
        cancelButton = AppLocalizations.of(context)!.cancel;
        break;
      case AlertType.sucess:
        title = AppLocalizations.of(context)!.success;
        okButton = AppLocalizations.of(context)!.ok;
        break;
      default:
        title = AppLocalizations.of(context)!.error;
        okButton = AppLocalizations.of(context)!.ok;
        break;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    // onPressed: onPress,
                    onPressed: () {
                      if (alertType == AlertType.warning) {
                        onPress == null ? Navigator.pop(context) : onPress();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(okButton),
                  ),
                  if (alertType == AlertType.warning)
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(cancelButton!),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void snack(BuildContext context, String message, {String? button}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          message,
        ),
      ),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(label: (button ?? AppLocalizations.of(context)!.ok), onPressed: () {}),
    ));
  }
}
