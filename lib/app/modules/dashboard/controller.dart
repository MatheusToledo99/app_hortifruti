import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  void changePageIndex(int index) {
    currentPageIndex.value = index;
  }
}
