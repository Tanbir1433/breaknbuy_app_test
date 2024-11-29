
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../buttons/border_button.dart';
import '../buy_product_widgets/change_adress_popup.dart';
import '../footer_widgets/icon_text.dart';
import '../product_details_widgets/uncopyable_icon_text.dart';
import '../product_details_widgets/uncopyable_icon_text_2.dart';
import 'change_user_details_pop_up.dart';

class PersonalProfileCardMedium extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  const PersonalProfileCardMedium(
      {super.key,
      required this.name,
      required this.email,
      required this.phone, required this.address});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Personal Profile ",
                  style: TextDesign()
                      .bnbBodyText
                      .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                UnCopyableIconText(
                  icon: Icons.person,
                  text: name,
                  textStyle:
                      TextDesign().bnbBodyText.copyWith(fontSize: 15),
                  iconSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                IconText(
                  icon: Icons.email,
                  text: email,
                  textStyle:
                      TextDesign().bnbBodyText.copyWith(fontSize: 15),
                  iconSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                IconText(
                  icon: Icons.phone,
                  text: phone,
                  textStyle:
                      TextDesign().bnbBodyText.copyWith(fontSize: 15),
                  iconSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                BorderButton(
                  icon: FontAwesomeIcons.userPen,
                  iconSize: 20,
                  onClick: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ChangeUserDetailPopUp();
                        });
                  },
                  text: "Change Details",
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: TextDesign().bnbBodyText.copyWith(fontSize: 22,fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: UnCopyableIconText2(
                    icon: Icons.location_on,
                    iconSize: 20,
                    text: address,
                    textStyle: TextDesign().bnbBodyText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BorderButton(
                  icon: Icons.change_circle_outlined,
                  iconSize: 20,
                  onClick: () {
                    ///
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ChangeAddressPopup();
                        });
                  },
                  text: "Change Address",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
