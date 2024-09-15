import 'package:get/get.dart';
import 'package:payuung/app/modules/searching/controllers/searching_controller.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());

    Get.lazyPut<SearchingController>(() => SearchingController());
  }
}
