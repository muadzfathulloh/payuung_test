import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';
import 'package:payuung/app/widgets/text_field_widget.dart';

import '../controllers/searching_controller.dart';

class SearchingView extends GetView<SearchingController> {
  const SearchingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchingController>(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              const Text('Cari Kebutuhanmu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFieldWidget(
                disableLabel: true,
                hintText: 'Cari',
                onChanged: (p0) {
                  _.searchedList = HomeController.to.products
                      .where((element) => element['title'].toString().toLowerCase().contains(p0.toString().toLowerCase()))
                      .toList();
                  _.update();
                },
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: SvgPicture.asset(
                    'assets/icons/cari.svg',
                    color: AppColor.grey400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Paling sering dicari', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                ),
                itemCount: _.searchedList.length,
                itemBuilder: (context, index) {
                  var item = _.searchedList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 130,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(item['image'] ?? 'assets/minyak.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(item['title'] ?? 'Voucher Digital Bakmi GM Rp. 100.000'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(item['original_price'] ?? 'Rp. 100.000',
                              style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 13)),
                          const SizedBox(width: 10),
                          Text('${item['discount'] ?? '20'}% OFF', style: const TextStyle(color: Colors.red, fontSize: 13)),
                        ],
                      ),
                      Text(item['price'] ?? 'Rp. 80.000'),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
