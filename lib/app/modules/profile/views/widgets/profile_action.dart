import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfieAction extends StatelessWidget {
  const ProfieAction({super.key, required this.name, required this.icon, this.onTap});
  final String name;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.grey),
            ),
            const SizedBox(width: 20),
            Text(name, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
