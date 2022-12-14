import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilServices {
  messageSnackBar(
      {required String message, bool isError = false, int duration = 3}) {
    return ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
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
      ),
    );
  }

  Future<bool> showDialogToChoose({required String message}) async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

  Future<void> showAlertDialog({
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
          textAlign: TextAlign.left,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
