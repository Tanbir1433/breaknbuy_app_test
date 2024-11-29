import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class SimpleButton extends StatelessWidget {
  final String? text;
  final Color? backGroundColor;
  final Color? buttonTextColor;
  final double? height;
  final double? width;
  final Function onClick;
  const SimpleButton(
      {super.key,
      this.text,
      this.backGroundColor,
      this.height,
      this.width,
      required this.onClick,
      this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backGroundColor ?? MyColor.bnbRed,
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: SizedBox(
          height: height ?? 48,
          width: width ?? 160,
          child: Center(
              child: Text(
            text ?? 'Submit',
            style: TextDesign().bnbButtonText.copyWith(
                color: buttonTextColor ?? MyColor.white,
                fontWeight: FontWeight.w700),
          )),
        ),
      ),
    );
  }
}
