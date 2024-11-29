import 'package:flutter/material.dart';

class UnCopyableIconText2 extends StatelessWidget {
  const UnCopyableIconText2({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textStyle,
    this.iconSize,
  });

  final IconData icon;
  final String text;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize ?? 30,
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Text(
            text,
            style: textStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
