import 'package:get/get.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';
import 'package:payuung/app/modules/profile/controllers/profile_controller.dart';
import 'package:payuung/app/modules/searching/controllers/searching_controller.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());

    Get.lazyPut<SearchingController>(() => SearchingController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
  }
}
