import 'package:flutter/material.dart';


import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class CustomSnackBar {
  static void showSnackBar(
      {required BuildContext context,
      required String message,
      required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextDesign().mtTableHeading.copyWith(color: MyColor.white),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: color,
        closeIconColor: MyColor.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),

        // action: SnackBarAction(
        //   label: 'Close',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   },
        // ),
      ),
    );
  }
}
