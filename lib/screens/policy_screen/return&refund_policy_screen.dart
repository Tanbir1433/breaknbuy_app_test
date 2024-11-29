
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const_config/color_config.dart';
import '../../const_config/demo_text.dart';
import '../../const_config/text_config.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/appbar/sliver_appbar_delegate.dart';
import '../../widgets/buttons/icon_text_button.dart';
import '../../widgets/global_widgets/footer.dart';

class ReturnRefundPolicyScreen extends StatelessWidget {
  const ReturnRefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bnbScaffold,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 100.0,
              maxHeight: 100.0,
              child: const BnbAppBar(
                isHome: false,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            sliver: SliverToBoxAdapter(
              child: Material(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconTextButton(
                            text: "বাংলায় পড়ুন",
                            icon: FontAwesomeIcons.fileLines,
                            onClick: () {},
                            backGroundColor: MyColor.bnbScaffold,
                            iconColor: MyColor.black,
                            textStyle: TextDesign().bnbBodyText,
                            width: 120,
                            height: 35,
                          ),
                        ],
                      ),
                      Text(
                        "Return Policy:",
                        style: TextDesign()
                            .bnbSubHeaderText
                            .copyWith(color: MyColor.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DemoText().termsCondition[0],
                        style: TextDesign().bnbBodyText,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "B. CONDITIONS OF USE",
                        style: TextDesign().mtBodyText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1. YOUR ACCOUNT",
                        style: TextDesign()
                            .mtBodyText
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        DemoText().termsCondition[1],
                        style: TextDesign().bnbBodyText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "2. Your account vs your order",
                        style: TextDesign()
                            .mtBodyText
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        DemoText().termsCondition[2],
                        style: TextDesign().bnbBodyText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Footer(),
          ),
        ],
      ),
    );
  }
}


