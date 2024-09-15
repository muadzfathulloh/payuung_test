import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';

class TimelineInfo extends StatelessWidget {
  const TimelineInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _.changeIndex(0);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(color: AppColor.primary, shape: BoxShape.circle),
                      child: const Center(
                        child: Text('1', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _.currentIndex == 0 ? 0.5 : 1,
                      backgroundColor: AppColor.primary.withOpacity(0.4),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _.changeIndex(1);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: _.currentIndex == 0 ? AppColor.primary.withOpacity(0.4) : AppColor.primary,
                          shape: BoxShape.circle),
                      child: const Center(
                        child: Text('2', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _.currentIndex == 2
                          ? 1
                          : _.currentIndex == 1
                              ? 0.5
                              : 0,
                      backgroundColor: AppColor.primary.withOpacity(0.4),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _.changeIndex(2);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: _.currentIndex == 2 ? AppColor.primary : AppColor.primary.withOpacity(0.4),
                          shape: BoxShape.circle),
                      child: const Center(
                        child: Text('3', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  child: Text('Biodata Diri', style: TextStyle(color: AppColor.primary), textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 80,
                  child: Text('Alamat Pribadi', style: TextStyle(color: AppColor.primary), textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 80,
                  child: Text('Informasi Perusahaan', style: TextStyle(color: AppColor.primary), textAlign: TextAlign.center),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
