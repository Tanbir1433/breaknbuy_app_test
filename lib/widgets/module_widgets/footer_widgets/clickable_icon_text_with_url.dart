import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class ClickableIconTextWithURL extends StatelessWidget {
  const ClickableIconTextWithURL({
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

  Future<void> launchInBrowser(Uri url) async {
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchInBrowser(Uri.parse(url));
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
