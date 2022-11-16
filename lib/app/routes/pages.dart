import 'package:app_hortifruti/app/modules/address/binding.dart';
import 'package:app_hortifruti/app/modules/address/page.dart';
import 'package:app_hortifruti/app/modules/cart/binding.dart';
import 'package:app_hortifruti/app/modules/cart/page.dart';
import 'package:app_hortifruti/app/modules/checkout/binding.dart';
import 'package:app_hortifruti/app/modules/checkout/page.dart';
import 'package:app_hortifruti/app/modules/cities/binding.dart';
import 'package:app_hortifruti/app/modules/cities/page.dart';
import 'package:app_hortifruti/app/modules/dashboard/binding.dart';
import 'package:app_hortifruti/app/modules/dashboard/page.dart';
import 'package:app_hortifruti/app/modules/login/binding.dart';
import 'package:app_hortifruti/app/modules/login/page.dart';
import 'package:app_hortifruti/app/modules/order_detail/binding.dart';
import 'package:app_hortifruti/app/modules/order_detail/page.dart';
import 'package:app_hortifruti/app/modules/product/binding.dart';
import 'package:app_hortifruti/app/modules/product/page.dart';
import 'package:app_hortifruti/app/modules/profile_addresses/binding.dart';
import 'package:app_hortifruti/app/modules/registration/binding.dart';
import 'package:app_hortifruti/app/modules/registration/page.dart';
import 'package:app_hortifruti/app/modules/store/binding.dart';
import 'package:app_hortifruti/app/modules/store/page.dart';
import 'package:get/get.dart';
import 'package:app_hortifruti/app/routes/routes.dart';

import '../modules/profile_addresses/page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.cities,
      page: () => const CitiesPage(),
      binding: CitiesBinding(),
    ),
    GetPage(
      name: Routes.dashBoard,
      page: () => const DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.store,
      page: () => const StorePage(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.checkout,
      page: () => const CheckoutPage(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.address,
      page: () => const AddressPage(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.profileAddresses,
      page: () => const ProfileAddressesPage(),
      binding: ProfileAddressesBinding(),
    ),
    GetPage(
      name: Routes.orderDetail,
      page: () => const OrderDetailPage(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: Routes.registration,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
    ),
  ];
}
