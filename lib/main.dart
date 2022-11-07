import 'package:app_hortifruti/app/core/theme/app_theme.dart';
import 'package:app_hortifruti/app/data/provider/api.dart';
import 'package:app_hortifruti/app/data/services/auth/repository.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:app_hortifruti/app/routes/pages.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'app/data/services/cart/service.dart';

void main() async {
  await GetStorage.init();

  Get.put<StorageService>(StorageService());
  Get.put<Api>(Api());
  Get.put<AuthService>(AuthService(AuthRepository(Get.find<Api>())));
  Get.put<CartService>(CartService());

  Intl.defaultLocale = 'pt_BR';
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.dashBoard,
      theme: themeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      locale: const Locale('pt', 'BR'),
    ),
  );
}
