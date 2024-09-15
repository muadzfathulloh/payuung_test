import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';
import 'package:payuung/app/modules/searching/controllers/searching_controller.dart';

import '../../../components/app_colors.dart';
import '../controllers/navigation_controller.dart';
import 'custom_navigation.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController.to;
    SearchingController.to;
    return WillPopScope(
      onWillPop: () {
        if (controller.currentIndex == 0) {
          return Future.value(false);
        } else {
          controller.changeIndex(0);
          return Future.value(false);
        }
      },
      child: GetBuilder<NavigationController>(
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _.listBody.elementAt(_.currentIndex),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                DraggableScrollableActuator(
                  child: DraggableScrollableSheet(
                    controller: _.draggableScrollableController,
                    initialChildSize: 0.12,
                    minChildSize: 0.12,
                    maxChildSize: 0.12 * ((_.listTitle.length / 3).ceil()),
                    builder: (context, scrollController) {
                      return CustomNavigation(
                        currentIndex: _.currentIndex,
                        onTap: _.changeIndex,
                        scrollController: scrollController,
                      );
                    },
                  ),
                ),
              ],
            ),
            // bottomNavigationBar:
            // CustomNavigation(
            //   currentIndex: _.currentIndex,
            //   onTap: _.changeIndex,
            // ),
          );
        },
      ),
    );
  }
}
