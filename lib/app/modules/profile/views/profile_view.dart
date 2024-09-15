import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/profile/views/widgets/profile_action.dart';
import 'package:payuung/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (_.profile.isNotEmpty)
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _.showImagePickerDialog(context);
                        },
                        child: _.image != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(File(_.image!.path)),
                              )
                            : Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    child: Text(_.profile['nama'][0], style: const TextStyle(fontSize: 20, color: Colors.white)),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: AppColor.grey400,
                                        shape: BoxShape.circle,
                                        border: Border.fromBorderSide(BorderSide(color: AppColor.white, width: 1)),
                                      ),
                                      child: const Icon(Icons.edit, color: Colors.white, size: 15),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(width: 10),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(_.profile['nama'] ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(_.profile['email'] ?? 'Masuk dengan Google'),
                      ]),
                    ],
                  ),
                const SizedBox(height: 20),
                ProfieAction(
                    name: 'Informasi Akun',
                    icon: Icons.person,
                    onTap: () async {
                      await controller.getProfile();
                      Get.toNamed(Routes.ACCOUNT);
                    }),
                const SizedBox(height: 15),
                ProfieAction(
                  name: 'Syarat dan Ketentuan',
                  icon: Icons.description,
                  onTap: () {
                    print(ProfileController.to.profile);
                  },
                ),
                const SizedBox(height: 15),
                const ProfieAction(name: 'Bantuan', icon: Icons.help),
                const SizedBox(height: 15),
                const ProfieAction(name: 'Kebijakan Privasi', icon: Icons.privacy_tip),
                const SizedBox(height: 15),
                if (_.profile.isNotEmpty) const ProfieAction(name: 'Keluar', icon: Icons.logout),
                const SizedBox(height: 15),
                if (_.profile.isNotEmpty)
                  ProfieAction(
                    name: 'Hapus Akun',
                    icon: Icons.delete,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Hapus Akun',
                        middleText: 'Apakah anda yakin ingin menghapus akun ini?',
                        textConfirm: 'Ya',
                        textCancel: 'Tidak',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColor.primary,
                        cancelTextColor: AppColor.primary,
                        onConfirm: () {
                          _.deleteProfile(controller.profile['id']);
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
