
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../buttons/border_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../footer_widgets/icon_text.dart';
import '../product_details_widgets/uncopyable_icon_text.dart';
import 'change_user_details_pop_up.dart';

class PersonalProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  final String address;
  const PersonalProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Material(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Profile ",
                        style: TextDesign().bnbBodyText.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      BorderButton(
                        height: 30,
                        width: 90,
                        iconSize: 18,
                        onClick: () {
                          auth.logout().then((value) {
                            if (value) {
                              auth.userLogInStatus == false;
                              auth.user.id = -1;
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: 'Successfully LogOut',
                                  color: MyColor.mtMainGreen);

                              Navigator.of(context).pushNamed('/LoginScreen');
                            } else {
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: 'Something went wrong',
                                  color: MyColor.red);
                            }
                          });
                        },
                        text: 'Log Out',
                        textStyle:
                            TextDesign().bnbBodyText.copyWith(fontSize: 12),
                        icon: Icons.logout_rounded,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        UnCopyableIconText(
                          icon: Icons.person,
                          text: name,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconText(
                          icon: Icons.email,
                          text: email,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconText(
                          icon: Icons.phone,
                          text: phone,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ),
                  BorderButton(
                    width: 150,
                    height: 40,
                    icon: FontAwesomeIcons.userPen,
                    iconSize: 16,
                    onClick: () {
                      ///
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ChangeUserDetailPopUp();
                          });
                    },
                    text: "Change Details",
                    textStyle: TextDesign().bnbBodyText.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
          );
  }
}
