import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import 'custom_snack_bar.dart';

class CopyAbleText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const CopyAbleText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: textStyle ?? TextDesign().mtButtonText.copyWith(color: MyColor.black),
      cursorWidth: 1.5,
      cursorColor: MyColor.white,
      enableInteractiveSelection: true,
      onTap: () {
        _copyToClipboard(context, text);
      },
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
