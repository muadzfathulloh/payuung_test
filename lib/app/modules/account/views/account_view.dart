import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payuung/app/modules/account/views/widgets/timeline_first.dart';
import 'package:payuung/app/modules/account/views/widgets/timeline_info.dart';
import 'package:payuung/app/modules/account/views/widgets/timeline_second.dart';
import 'package:payuung/app/modules/account/views/widgets/timeline_third.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
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
            'Informasi Akun',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<AccountController>(
            init: AccountController(),
            initState: (_) {},
            builder: (_) {
              return Column(
                children: [
                  const TimelineInfo(),
                  const SizedBox(height: 20),
                  //PageView Timeline
                  Expanded(
                    child: PageView(
                      controller: _.pageController,
                      onPageChanged: (index) {
                        _.changeIndex(index);
                      },
                      children: const [
                        TimelineFirst(),
                        TimelineSecond(),
                        TimelineThird(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
