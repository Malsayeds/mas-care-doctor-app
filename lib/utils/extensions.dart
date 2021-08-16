import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension StatusColor on int {
  Color? getStatusColor() {
    switch (this) {
      case 0:
        return Colors.yellow;
      case 1:
        return greenColor;
      case 2:
        return redColor;
      default:
        return Colors.grey;
    }
  }
}
