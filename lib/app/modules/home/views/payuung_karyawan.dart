import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';
import 'package:payuung/app/widgets/app_button.dart';

class PayuungKaryawan extends GetView<HomeController> {
  const PayuungKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton.elevated(
          width: 200,
          text: 'Daftar Sekarang!',
        ),
      ],
    );
  }
}
