import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/data/core/sqflite_core.dart';
import 'package:payuung/app/modules/home/controllers/home_controller.dart';
import 'package:payuung/app/modules/home/views/widgets/home_grid.dart';

class PayuungPribadi extends StatefulWidget {
  const PayuungPribadi({super.key});

  @override
  State<PayuungPribadi> createState() => _PayuungPribadiState();
}

class _PayuungPribadiState extends State<PayuungPribadi> {
  String _selectedValue = 'Terpopuler';
  final List<String> _dropdownItems = ['Terpopuler', 'Terbaru', 'Harga Terendah', 'Harga Tertinggi'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HomeGrid(category: 'Produk Keuangan', list: HomeController.to.keuangan),
        const SizedBox(height: 10),
        HomeGrid(category: 'Kategori Pilihan', list: HomeController.to.kategori),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Explore Wellness', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  padding: EdgeInsets.zero,
                  isDense: true,
                  value: _selectedValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: _dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(height: 0, fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GetBuilder<HomeController>(
          builder: (_) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
              ),
              itemCount: _.products.length,
              itemBuilder: (context, index) {
                var item = _.products[index];
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
            );
          },
        )
      ],
    );
  }
}
