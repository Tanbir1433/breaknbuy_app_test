import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class ClickableIconText extends StatelessWidget {
  const ClickableIconText({
    super.key,
    required this.url,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
    this.iconSize,
  });

  final String url;
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor ?? MyColor.white,
            size: iconSize ?? 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: TextDesign().bnbButtonText.copyWith(
              color: textColor ?? MyColor.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
