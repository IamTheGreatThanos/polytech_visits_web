import 'package:flutter/material.dart';

import '../utils/styles/color_palette.dart';
import '../utils/styles/styles.dart';

Widget customFullWidthButton(
  VoidCallback onTap, {
  String title = '',
  Color backgroundColor = ColorPalette.main,
  Color textColor = Colors.white,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size.fromHeight(60), // NEW
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: ProjectStyles.textStyle_14Bold.copyWith(color: textColor),
      ),
    ),
  );
}
