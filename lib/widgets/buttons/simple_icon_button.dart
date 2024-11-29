import 'package:flutter/material.dart';
import '../../const_config/color_config.dart';

class SimpleIconButton extends StatelessWidget {
  final IconData? icon;
  final Color? backGroundColor;
  final double? height;
  final double? width;
  final Function onClick;
  const SimpleIconButton(
      {super.key,
      this.icon,
      this.backGroundColor,
      this.height,
      this.width,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backGroundColor ?? MyColor.mtMainGreen,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: SizedBox(
          height: height ?? 48,
          width: width ?? 160,
          child: Center(
            child: Icon(
              icon ?? Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
