import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilServices {
  messageSnackBar({required String message, bool isError = false}) {
    return SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      elevation: 5,
    );
  }

  Future<bool> showDialogToChoose({required String message}) async {
    return await Get.dialog(
      AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Voltar')),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future showAlertDialog({
    required String message,
    String? route,
    String? routeMessage,
    bool barrierDismissible = false,
    int arguments = 0,
  }) async {
    return await Get.dialog(
      barrierDismissible: barrierDismissible,
      AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: [
          if (route != null)
            TextButton(
              onPressed: () => Get.offAllNamed(route, arguments: arguments),
              child: Text(routeMessage ?? ''),
            )
        ],
      ),
    );
  }
}
