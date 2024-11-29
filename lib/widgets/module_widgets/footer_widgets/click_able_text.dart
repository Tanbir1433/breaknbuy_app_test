
import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class ClickAbleText extends StatelessWidget {
  const ClickAbleText({
    super.key, required this.url, required this.text, this.iconColor, this.textColor, this.textStyle,
  });

  final String url;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {

    Future<void> launchInBrowser(Uri url) async {
      // if (!await launchUrl(
      //   url,
      //   mode: LaunchMode.externalApplication,
      // )) {
      //   throw Exception('Could not launch $url');
      // }
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(url);
        // launchInBrowser(Uri.parse(
        //     url));
      },
      child: Text(
        text,
        style:textStyle?? TextDesign().bnbButtonText.copyWith(color: textColor ?? MyColor.white,fontSize: 14),
      ),
    );
  }
}
