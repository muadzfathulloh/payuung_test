import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/data/core/sqflite_core.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSqlite().database;
  await AppSqlite().productDb;

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
