import 'package:flutter/material.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/text_style.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(
          message,
          style: AppTextStyles.appButton,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
