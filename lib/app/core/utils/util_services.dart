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

  Future<bool> showDialogNewCart({required String message}) async {
    return await Get.dialog(
      AlertDialog(
        content: Text(message),
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
}
