import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class CardIconTextButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? backGroundColor;
  final Color? buttonTextColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final Function onClick;
  const CardIconTextButton(
      {super.key,
      this.text,
      this.backGroundColor,
      this.height,
      this.width,
      required this.onClick,
      this.icon,
      this.buttonTextColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Material(
        color: backGroundColor ?? MyColor.mtMainGreen,
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          height: height ?? 40,
          width: width ?? 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon ?? FontAwesomeIcons.dollarSign,
                color: iconColor ?? Colors.white,
                size: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text ?? 'Add to Cart',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextDesign()
                    .bnbBodyText
                    .copyWith(color: buttonTextColor ?? MyColor.white),
              ),
              const SizedBox(
                width: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
