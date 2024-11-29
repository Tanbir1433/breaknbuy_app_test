
import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/demo_text.dart';
import '../../const_config/text_config.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/footer.dart';

class FAQScreen extends StatelessWidget {
  const
  FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bnbScaffold,
      body: Column(
        children: [
          const Flexible(
            flex: 0,
            child: BnbAppBar(
                isHome: false,
              ),
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Frequently Asked Questions",
                    style: TextDesign()
                        .bnbHeaderText
                        .copyWith(color: MyColor.black),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Material(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width:double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DemoText().FAQ[0],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextDesign()
                                    .bnbSubHeaderText
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                DemoText().FAQ[1],
                                style: TextDesign().bnbBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Material(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width:double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DemoText().FAQ[2],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextDesign()
                                    .bnbSubHeaderText
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                DemoText().FAQ[3],
                                style: TextDesign().bnbBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Material(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width:double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DemoText().FAQ[4],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextDesign()
                                    .bnbSubHeaderText
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                DemoText().FAQ[5],
                                style: TextDesign().bnbBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Material(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width:double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DemoText().FAQ[6],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextDesign()
                                    .bnbSubHeaderText
                                    .copyWith(fontSize: 18,overflow: TextOverflow.clip,),
                              ),
                              Text(
                                DemoText().FAQ[7],
                                style: TextDesign().bnbBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Footer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
