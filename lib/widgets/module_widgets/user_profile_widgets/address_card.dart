import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../buttons/border_button.dart';
import '../buy_product_widgets/change_adress_popup.dart';
import '../product_details_widgets/uncopyable_icon_text_2.dart';

class AddressCard extends StatelessWidget {
  final String address;

  const AddressCard({
    super.key,
    required this.address,

  });

  @override
  Widget build(BuildContext context) {
    return Material(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Address",
                    style: TextDesign()
                        .bnbBodyText
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UnCopyableIconText2(
                    icon: Icons.location_on,
                    text: address,
                    textStyle: TextDesign().bnbBodyText,
                    iconSize: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BorderButton(
                    height: 40,
                    width: 150,
                    icon: Icons.change_circle_outlined,
                    iconSize: 16,
                    onClick: () {
                      ///
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ChangeAddressPopup();
                        },
                      );
                    },
                    text: "Change Address",
                    textStyle: TextDesign().bnbBodyText.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
  }
}
