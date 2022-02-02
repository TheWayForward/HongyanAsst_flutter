import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';

commonAppBar(String title, bool bold) {
  return AppBar(
      backgroundColor: ColorHelper.primary,
      title: Text(title,
          style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal)));
}
