
import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../buttons/border_button.dart';
import '../../buttons/simple_button.dart';
import '../footer_widgets/icon_text.dart';
import '../product_details_widgets/uncopyable_icon_text_2.dart';
import 'change_adress_popup.dart';

class OrderCard extends StatelessWidget {
  final String address;
  final String deliveryTime;
  final String phone;
  final String gmail;
  final Function onclick;

  const OrderCard({
    super.key,
    required this.address,
    required this.deliveryTime,
    required this.phone,
    required this.gmail,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Material(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Order Details",
                    style: TextDesign().bnbSubHeaderText,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        UnCopyableIconText2(
                          icon: Icons.timer,
                          text: deliveryTime,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 24,
                        ),
                        const Divider(),
                        UnCopyableIconText2(
                          icon: Icons.location_on,
                          text: address,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 24,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconText(
                          icon: Icons.call,
                          text: phone,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 24,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconText(
                          icon: Icons.mail,
                          text: gmail,
                          textStyle: TextDesign().bnbBodyText,
                          iconSize: 24,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: BorderButton(
                      backGroundColor: MyColor.white,
                      icon: Icons.change_circle_outlined,
                      text: "Change Address",
                      width: 165,
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ChangeAddressPopup();
                            });
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: SimpleButton(
                    onClick: onclick,
                    text: "Check Out",
                    backGroundColor: MyColor.bnbRed,
                    width: 200,
                  )),
                ],
              ),
            ),
          );
  }
}
