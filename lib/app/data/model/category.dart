import 'package:flutter/widgets.dart';

class Category {
  String? name;
  String? icon;
  Color? color;
  bool isNew;
  Category({this.name, this.icon, this.color, this.isNew = false});
}
