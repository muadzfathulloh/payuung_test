import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung/app/data/model/category.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key, required this.category, required this.list, this.extension});
  final String category;
  final List<Category> list;
  final Widget? extension;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.05,
          ),
          itemCount: list.length > 8 ? 8 : list.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 28,
                        child: list.length > 8 && index == 7
                            ? SvgPicture.asset('assets/icons/more.svg', color: Colors.black, height: 30, width: 30)
                            : SvgPicture.asset(
                                list[index].icon ?? 'assets/icons/financial.svg',
                                color: list[index].color ?? Colors.black,
                                fit: BoxFit.contain,
                              ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        list.length > 8 && index == 7 ? 'Lihat Semua' : list[index].name ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (list[index].isNew ?? false)
                  Positioned(
                    top: 0,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('NEW', style: TextStyle(fontSize: 8, color: Colors.white)),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
