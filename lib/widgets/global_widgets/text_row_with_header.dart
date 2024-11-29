import 'package:flutter/material.dart';

import '../../const_config/text_config.dart';

class TextRowWithHeader extends StatelessWidget {
  final int? bodyTextMaxLine;
  final TextStyle? bodyTextStyle;
  const TextRowWithHeader({
    super.key,
    required this.bodyText, required this.headerText, this.bodyTextMaxLine, this.bodyTextStyle,
  });

  final String bodyText;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$headerText: ",
            style: TextDesign().bnbButtonText
          ),
          Flexible(
            child: Text(
              bodyText,
              style: bodyTextStyle ?? TextDesign().bnbButtonText.copyWith(
                  fontWeight: FontWeight.w800
              ),
              maxLines:bodyTextMaxLine??1 ,

              overflow: TextOverflow.ellipsis,

            ),
          ),
        ],
      ),
    );
  }
}