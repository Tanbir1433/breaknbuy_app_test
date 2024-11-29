import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/auth/auth_provider.dart';

import '../module_widgets/footer_widgets/click_able_text.dart';
import '../module_widgets/footer_widgets/clickable_icon_text_with_url.dart';
import '../module_widgets/footer_widgets/icon_text.dart';
import 'developer_tag.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          clipBehavior: Clip.hardEdge,
          color: MyColor.bnbGrey,
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(100),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/images/logo.jpeg",
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let Us Help You",
                              style: TextDesign()
                                  .mtButtonText
                                  .copyWith(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ClickAbleText(
                              url: auth.userLogInStatus
                                  ? "/UserProfileScreen"
                                  : "/LoginScreen",
                              text: "Your Account",
                              textStyle: TextDesign().bnbBodyText.copyWith(
                                  color: MyColor.bnbFlashWhite, fontSize: 11),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ClickAbleText(
                              url: "/TermsConditionsScreen",
                              text: "Terms & Conditions",
                              textStyle: TextDesign().bnbBodyText.copyWith(
                                  color: MyColor.bnbFlashWhite, fontSize: 11),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ClickAbleText(
                              url: "/ReturnRefundPolicyScreen",
                              text: "Return Policy",
                              textStyle: TextDesign().bnbBodyText.copyWith(
                                  color: MyColor.bnbFlashWhite, fontSize: 11),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ClickAbleText(
                              url: "/FAQScreen",
                              text: "FAQ",
                              textStyle: TextDesign()
                                  .bnbBodyText
                                  .copyWith(color: MyColor.bnbFlashWhite,fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Social",
                          style: TextDesign()
                              .mtButtonText
                              .copyWith(fontSize: 15),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClickableIconTextWithURL(
                              url: 'https://www.facebook.com/breaknbuy',
                              icon: FontAwesomeIcons.facebook,
                              text: '',
                              iconSize: 20,
                            ),
                            ClickableIconTextWithURL(
                              url: '///',
                              icon: FontAwesomeIcons.instagram,
                              text: '',
                              iconSize: 20,
                            ),
                            ClickableIconTextWithURL(
                              url: 'https://wa.link/4tfe73',
                              icon: FontAwesomeIcons.whatsapp,
                              text: '',
                              iconSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Contact",
                          style: TextDesign()
                              .mtButtonText
                              .copyWith(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconText(
                          textStyle: TextDesign()
                              .vdBodyText
                              .copyWith(color: MyColor.white, fontSize: 13),
                          iconColor: MyColor.white,
                          iconSize: 15,
                          icon: Icons.phone_in_talk_rounded,
                          text: '+880 1953 366709\n+880 1757 366709',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconText(
                          icon: Icons.mail_outline_rounded,
                          iconSize: 15,
                          text: 'breaknbuy@gmail.com',
                          iconColor: MyColor.white,
                          textStyle: TextDesign()
                              .vdBodyText
                              .copyWith(color: MyColor.white, fontSize: 12,overflow: TextOverflow.clip,),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        ),
        const Material(
          color: MyColor.bnbGrey,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.zero,
          child: SizedBox(
            child: DeveloperTag(),
          ),
        ),
      ],
    );
  }
}
