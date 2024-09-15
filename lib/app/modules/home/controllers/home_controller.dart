import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/data/core/sqflite_core.dart';
import 'package:payuung/app/data/model/category.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.isRegistered<HomeController>() ? Get.find() : Get.put(HomeController());

  AppSqlite appSqlite = AppSqlite();

  List<Category> keuangan = [
    Category(name: 'Urun', icon: 'assets/icons/urun.svg', color: Colors.brown.shade400, isNew: true),
    Category(name: 'Pembiayaan Porsi Haji', icon: 'assets/icons/haji.svg', color: Colors.green),
    Category(name: 'Financial Check Up', icon: 'assets/icons/financial.svg', color: Colors.yellow.shade700),
    Category(name: 'Asuransi Mobil', icon: 'assets/icons/car.svg', color: Colors.blueGrey),
    Category(name: 'Asuransi Properti', icon: 'assets/icons/properti.svg', color: Colors.red.shade400),
  ];
  List<Category> kategori = [
    Category(name: 'Hobi', icon: 'assets/icons/hobi.svg', color: Colors.blue.shade600),
    Category(name: 'Merchandise', icon: 'assets/icons/merchandise.svg', color: Colors.yellow.shade700),
    Category(name: 'Gaya Hidup Sehat', icon: 'assets/icons/heart.svg', color: Colors.red),
    Category(name: 'Konseling & Rohani', icon: 'assets/icons/konseling.svg', color: Colors.blue),
    Category(name: 'Self Development', icon: 'assets/icons/self_development.svg', color: Colors.deepPurple),
    Category(name: 'Perencanaan Keuangan', icon: 'assets/icons/card.svg', color: Colors.green.shade400),
    Category(name: 'Konsultasi Medis', icon: 'assets/icons/medis.svg', color: Colors.green.shade700),
    Category(name: 'Konsultasi Gizi', icon: 'assets/icons/konseling.svg', color: Colors.blue),
    Category(name: 'Konsultasi Psikologi', icon: 'assets/icons/konseling.svg', color: Colors.blue),
  ];

  List<Map<String, dynamic>> products = [];

  @override
  onInit() {
    super.onInit();
    getProduct();
  }

  Future<void> insertProductDB() async {
    for (Map<String, dynamic> item in wellness) {
      await appSqlite.insertProduct({
        'title': item['title'],
        'image': item['image'],
        'original_price': item['original_price'],
        'price': item['price'],
        'discount': item['discount'],
      });
    }
  }

  //get product from db
  Future<void> getProduct() async {
    products = await appSqlite.getProducts();
    if (products.isEmpty) {
      await insertProductDB();
      products = await appSqlite.getProducts();
    }
    update();
  }

  List<Map<String, String>> wellness = [
    {
      'title': 'Minyak Goreng Indomaret 2 Liter Diskon 20%',
      'image': 'assets/minyak.png',
      'original_price': 'Rp. 100.000',
      'price': 'Rp. 80.000',
      'discount': '20'
    },
    {
      'title': 'Coca Cola Soft Drink 500 mL',
      'image': 'assets/cola.png',
      'original_price': 'Rp. 10.000',
      'price': 'Rp. 7.000',
      'discount': '30'
    },
    {
      'title': 'Susu Ultra Milk 1 Liter',
      'image': 'assets/susu.png',
      'original_price': 'Rp. 50.000',
      'price': 'Rp. 45.000',
      'discount': '10'
    },
    {
      'title': 'Tisu Indomaret 200 Sheet',
      'image': 'assets/tisu.png',
      'original_price': 'Rp. 20.000',
      'price': 'Rp. 15.000',
      'discount': '25'
    },
    {
      'title': 'Le Minerale Tanggung 500 mL',
      'image': 'assets/mineral.png',
      'original_price': 'Rp. 10.000',
      'price': 'Rp. 8.000',
      'discount': '20'
    },
    {
      'title': 'Beras 10 Kg',
      'image': 'assets/beras.png',
      'original_price': 'Rp. 100.000',
      'price': 'Rp. 90.000',
      'discount': '10'
    },
    {
      'title': 'Oreo Black Pink Limited Edition',
      'image': 'assets/oreo.png',
      'original_price': 'Rp. 20.000',
      'price': 'Rp. 15.000',
      'discount': '25'
    },
    {
      'title': 'Ramen Gekikara Kuah Peda Rasa Jeruk Nipis',
      'image': 'assets/ramen.png',
      'original_price': 'Rp. 10.000',
      'price': 'Rp. 8.000',
      'discount': '20'
    },
  ];
}
