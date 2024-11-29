import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class BorderButton extends StatelessWidget {
  final String? text;
  final Color? backGroundColor;
  final double? height;
  final double? width;
  final Function onClick;
  final IconData? icon;
  final TextStyle? textStyle;
  final double? iconSize;

  const BorderButton(
      {super.key,
      this.text,
      this.backGroundColor,
      this.height,
      this.width,
      required this.onClick,
      this.icon,
      this.textStyle, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backGroundColor ?? MyColor.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: MyColor.vdOxfordBlue, width: 1),
      ),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: SizedBox(
          height: height ?? 40,
          width: width ?? 160,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon,size: iconSize,),
                  Flexible(
                    child: Text(
                      text ?? 'Submit',
                      style: textStyle ?? TextDesign().vdButtonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
