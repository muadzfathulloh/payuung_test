import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung/app/data/core/sqflite_core.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.isRegistered<ProfileController>() ? Get.find() : Get.put(ProfileController());

  AppSqlite appSqlite = AppSqlite();

  List<Map<String, dynamic>> profiles = [];
  Map<String, dynamic> profile = {};

  // imagepicked/
  XFile? image;
  final picker = ImagePicker();

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    profiles = await appSqlite.getItems();
    if (profiles.isNotEmpty) {
      profile = profiles[0];
      print(profile);
    }
    update();
  }

  //delete profile
  Future<void> deleteProfile(int id) async {
    await appSqlite.deleteItem(id);
    profile = {};
    image = null;
    update();
    Get.back();
    // getProfile();
  }

  Future<void> showImagePickerDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    print('Gambar dari galeri: ${image!.path}');
                  }
                  update();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    print('Gambar dari kamera: ${image!.path}');
                  }
                  update();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
