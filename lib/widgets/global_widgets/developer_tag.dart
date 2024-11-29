import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const_config/text_config.dart';

class DeveloperTag extends StatelessWidget {
  const DeveloperTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
    return InkWell(
      onTap: () {
        launchInBrowser(Uri.parse("https://sharpdevsbd.com/"));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Developed By ',
            style: TextDesign().vdBodyText.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Image.asset(
                'assets/images/sdlogo_grey.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
