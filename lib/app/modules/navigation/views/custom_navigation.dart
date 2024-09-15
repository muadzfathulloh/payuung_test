import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:payuung/app/routes/app_pages.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.scrollController,
  });
  final int currentIndex;
  final Function(int) onTap;
  final ScrollController scrollController;

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  double extent = 0.0;
  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      scrollController = widget.scrollController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          extent = notification.extent;
        });
        return true;
      },
      child: Stack(
        children: [
          Positioned.fill(
            top: 19,
            child: Container(height: 1, color: Colors.grey),
          ),
          Positioned.fill(
            top: 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.only(top: 1, right: 1, left: 1),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(color: Colors.white),
            // padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: ListView(
              padding: EdgeInsets.zero,
              controller: widget.scrollController,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 6),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  itemCount: NavigationController.to.listTitle.length,
                  itemBuilder: (context, index) {
                    var item = NavigationController.to.listTitle[index];
                    return GestureDetector(
                      onTap: () {
                        if (index < 3) {
                          widget.onTap(index);
                        } else {
                          Get.toNamed(Routes.PROFILE);
                        }
                      },
                      child: Container(
                        // color: currentIndex == index ? Colors.amber : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              item['icon'] ?? 'assets/icons/beranda.svg',
                              color: widget.currentIndex == index ? AppColor.secondary : Colors.grey,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['title'] ?? 'Beranda',
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.currentIndex == index ? AppColor.secondary : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 10,
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  if (extent > 0.3) {
                    setState(() {
                      extent = 0.0;
                    });
                    NavigationController.to.draggableScrollableController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    setState(() {
                      extent = 0.32;
                    });
                    NavigationController.to.draggableScrollableController.animateTo(
                      0.32,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                  NavigationController.to.update();
                },
                child: SizedBox(
                  height: 17,
                  width: 17,
                  child: AnimatedRotation(
                    turns: extent > 0.3 ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_up.svg',
                      height: 10,
                      width: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //  return Theme(
    //   data: ThemeData(
    //     splashColor: Colors.transparent,
    //     highlightColor: Colors.transparent,
    //   ),
    //   child: BottomAppBar(
    //     padding: EdgeInsets.zero,
    //     child: BottomNavigationBar(
    //       backgroundColor: Colors.white,
    //       currentIndex: currentIndex,
    //       onTap: onTap,
    //       type: BottomNavigationBarType.fixed,
    //       enableFeedback: false,
    //       unselectedItemColor: Colors.grey,
    //       selectedItemColor: Colors.amber,
    //       unselectedFontSize: 12,
    //       selectedFontSize: 12,
    //       elevation: 0,
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             currentIndex == 0 ? Icons.home : Icons.home_outlined,
    //             color: currentIndex == 0 ? Colors.amber : Colors.grey,
    //           ),
    //           label: 'Beranda',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             currentIndex == 1 ? Icons.search : Icons.search_outlined,
    //             color: currentIndex == 1 ? Colors.amber : Colors.grey,
    //           ),
    //           label: 'Cari',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
    //             color: currentIndex == 2 ? Colors.amber : Colors.grey,
    //           ),
    //           label: 'Favorit',
    //         ),
    //       ],
    //     ),
    //   ),
    // )
  }
}
