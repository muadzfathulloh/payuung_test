import 'package:get/get.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';

class SearchingController extends GetxController {
  static SearchingController get to => Get.isRegistered<SearchingController>() ? Get.find() : Get.put(SearchingController());
  //TODO: Implement SearchingController

  List<Map<String, dynamic>> searchedList = [];

  @override
  void onInit() {
    super.onInit();
    searchedList = HomeController.to.products;
    update();
  }

  final count = 0.obs;

  void increment() => count.value++;
}
