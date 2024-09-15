import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/modules/searching/views/searching_view.dart';

import '../../home/views/home_view.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.isRegistered<NavigationController>() ? Get.find() : Get.put(NavigationController());
  var currentIndex = 0;
  final DraggableScrollableController draggableScrollableController = DraggableScrollableController();

  List<Widget> listBody = [
    const HomeView(),
    const SearchingView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
    // const HomeView(),
    // const HomeView(),
  ];

  List<Map<String, String>> listTitle = [
    {
      'title': 'Beranda',
      'icon': 'assets/icons/beranda.svg',
    },
    {
      'title': 'Cari',
      'icon': 'assets/icons/cari.svg',
    },
    {
      'title': 'Keranjang',
      'icon': 'assets/icons/cart.svg',
    },
    {
      'title': 'Daftar Transaksi',
      'icon': 'assets/icons/transaksi.svg',
    },
    {
      'title': 'Voucher Saya',
      'icon': 'assets/icons/voucher.svg',
    },
    {
      'title': 'Alamat',
      'icon': 'assets/icons/alamat.svg',
    },
    {
      'title': 'Daftar Teman',
      'icon': 'assets/icons/teman.svg',
    }
  ];

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    currentIndex = 0;
    update();
  }

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
