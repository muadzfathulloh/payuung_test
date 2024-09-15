import 'package:get/get.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';
import 'package:payuung/app/modules/profile/controllers/profile_controller.dart';
import 'package:payuung/app/modules/searching/controllers/searching_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
    Get.lazyPut<SearchingController>(() => SearchingController(), fenix: true);
  }
}
