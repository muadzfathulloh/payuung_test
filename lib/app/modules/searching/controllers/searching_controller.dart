import 'package:get/get.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';

class SearchingController extends GetxController {
  //TODO: Implement SearchingController

  List<Map<String, dynamic>> searchedList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchedList = HomeController.to.products;
  }

  final count = 0.obs;

  void increment() => count.value++;
}
