
import 'package:flutter/material.dart';

class GradientItem {
  String title;
  bool isSelected = false;
  List<Color> gradientColor;
  GradientItem(this.title, this.gradientColor, this.isSelected);
}