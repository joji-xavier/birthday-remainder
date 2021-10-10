// ignore_for_file: use_key_in_widget_constructors

import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

   const Button({
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}