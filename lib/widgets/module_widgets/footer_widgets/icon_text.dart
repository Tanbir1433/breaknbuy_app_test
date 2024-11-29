

import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import 'package:flutter/services.dart';

import '../../global_widgets/custom_snack_bar.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,required this.icon, required this.text, this.iconColor, this.textStyle, this.iconSize,
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
          size:iconSize?? 30,
        ),
        const SizedBox(
          width: 10,
        ),
        SelectableText(
          text,
          style: textStyle,

          cursorWidth: 1.5,
          cursorColor: MyColor.white,
          enableInteractiveSelection: true,
          onTap: () {
            _copyToClipboard(context, text);
          },
        ),
      ],
    );
  }
  void _copyToClipboard(BuildContext context, String text) {

    Clipboard.setData(ClipboardData(text: text));

    CustomSnackBar.showSnackBar(
        context: context,
        message: 'Copied to clipboard: $text',
        color: MyColor.green);

  }
}
