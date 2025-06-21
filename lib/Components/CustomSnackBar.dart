import 'package:flutter/material.dart';
import '../utils/color_constants.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: primarycolor, fontFamily: "Poppins",fontSize: 14 ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
      ),
    );
  }
}