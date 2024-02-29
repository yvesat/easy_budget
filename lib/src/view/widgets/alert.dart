import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/enums/alert_type.dart';

class Alert {
  dialog(BuildContext context, AlertType tipo, String mensagem, {VoidCallback? onPress}) {
    String titulo;
    String okButton;
    String? cancelButton;

    switch (tipo) {
      case AlertType.error:
        titulo = "Error";
        okButton = "OK";
        break;
      case AlertType.warning:
        titulo = "Warning";
        okButton = "CONFIRM";
        cancelButton = "CANCEL";
        break;
      case AlertType.sucess:
        titulo = "Sucess";
        okButton = "OK";
        break;
      default:
        titulo = "Error";
        okButton = "OK";
        break;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          child: AlertDialog(
            title: Text(titulo),
            content: Text(mensagem),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    // onPressed: onPress,
                    onPressed: () {
                      if (tipo == AlertType.warning) {
                        onPress == null ? Navigator.pop(context) : onPress();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(okButton),
                  ),
                  if (tipo == AlertType.warning)
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

  snack(BuildContext context, String mensagem, {String? botao}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          mensagem,
        ),
      ),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(label: (botao ?? "OK"), onPressed: () {}),
    ));
  }
}

final alertaProvider = Provider((_) => Alert());
