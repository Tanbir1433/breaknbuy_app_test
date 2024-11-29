import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class SectionBannerHeader extends StatelessWidget {
  final String text;
  final String imagePath;
  final TextStyle? textStyle;
  final bool isRight;
  final double? mediumScreenImgWidth;
  final bool isMobileScreen;

  const SectionBannerHeader({
    super.key,
    required this.text,
    required this.imagePath,
    this.textStyle,
    required this.isRight,
    this.mediumScreenImgWidth,
    required this.isMobileScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: isMobileScreen
            ? Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        imagePath,
                        width: 100,
                      ),
                    ],
                  ),
                  Text(
                    text,
                    style: textStyle ?? TextDesign().bnbBannerText,
                  ),
                ],
              )
            : isRight
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Image.asset(
                          imagePath,
                          width: mediumScreenImgWidth ?? 180,
                        ),
                      ),
                      Text(
                        text,
                        style: textStyle ?? TextDesign().bnbBannerText,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: textStyle ?? TextDesign().bnbBannerText,
                      ),
                      Center(
                        child: Image.asset(
                          imagePath,
                          width: mediumScreenImgWidth ?? 180,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
