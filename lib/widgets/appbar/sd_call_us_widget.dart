
import 'package:flutter/material.dart';
import '../../const_config/text_config.dart';
import '../global_widgets/copy_able_text.dart';

class SdCallUsWidget extends StatelessWidget {
  const SdCallUsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Row(
        children: [
          const Icon(
            Icons.call,
            size: 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Call Us Anytime",
                style: TextDesign().bodyTextLarge,
              ),
              const CopyAbleText(
                text: "01581-324893",
              )
            ],
          ),
        ],
      ),
    );
  }
}