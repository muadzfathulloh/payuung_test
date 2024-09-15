import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/home/views/payuung_karyawan.dart';
import 'package:payuung/app/modules/home/views/payuung_pribadi.dart';
import 'package:payuung/app/modules/profile/controllers/profile_controller.dart';
import 'package:payuung/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProfileController.to;
    String greetingMessage() {
      final hour = DateTime.now().toLocal().hour;
      if (hour < 12) {
        return 'Selamat Pagi';
      } else if (hour < 18) {
        return 'Selamat Siang';
      } else {
        return 'Selamat Malam';
      }
    }

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Column(
        children: [
          GetBuilder<ProfileController>(
            builder: (_) {
              return Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                width: Get.width,
                color: AppColor.primary,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greetingMessage(), style: const TextStyle(fontSize: 15, color: Colors.white)),
                        if (_.profile.isNotEmpty)
                          Text(_.profile['nama'] ?? '',
                              style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.grey600,
                        backgroundImage: _.image != null ? FileImage(File(_.image!.path)) : null,
                        child: _.image != null
                            ? null
                            : _.profile.isNotEmpty
                                ? Text(_.profile['nama']?[0].toString().toUpperCase() ?? '',
                                    style: const TextStyle(color: AppColor.grey300))
                                : const Icon(Icons.person, color: AppColor.grey400),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: ShapeDecoration(
                        color: AppColor.grey600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.all(6),
                        indicator: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        labelColor: AppColor.white,
                        unselectedLabelColor: AppColor.grey400,
                        tabs: const [
                          Tab(text: 'Payuung Pribadi'),
                          Tab(text: 'Payuung Karyawan'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Expanded(
                      child: TabBarView(
                        children: [PayuungPribadi(), PayuungKaryawan()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
