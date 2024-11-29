import 'package:flutter/material.dart';


import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class IconTextButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? backGroundColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Function onClick;
  const IconTextButton(
      {super.key,
      this.text,
      this.backGroundColor,
      this.height,
      this.width,
      required this.onClick,
      this.icon,
      this.iconColor,
      this.textStyle});

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
          height: height ?? 44,
          width: width ?? 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor ?? MyColor.white,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text ?? 'Log in',
                style:textStyle?? TextDesign().bnbButtonText.copyWith(
                    color: MyColor.white,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
