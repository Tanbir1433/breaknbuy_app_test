import 'package:breaknbuy_app/widgets/module_widgets/product_details_widgets/uncopyable_icon_text_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class ProductDeliveryDetails extends StatelessWidget {
  final String deliveryDays;
  final String deliveryType;
  final String price;
  final String address;
  final String deliveryTime;
  final String phone;
  final String gmail;
  const ProductDeliveryDetails({
    super.key,
    required this.deliveryDays,
    required this.deliveryType,
    required this.price,
    required this.address,
    required this.deliveryTime,
    required this.phone,
    required this.gmail,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: MyColor.white,
      child: SizedBox(
        height: 450,
       // width: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Details",
                style: TextDesign().bnbSubHeaderText,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 5,),
                    UnCopyableIconText2(icon: FontAwesomeIcons.truck, text: deliveryDays, textStyle: TextDesign().bnbBodyText,),
                    UnCopyableIconText2(icon: FontAwesomeIcons.moneyBill, text: deliveryType, textStyle: TextDesign().bnbBodyText,),
                    UnCopyableIconText2(icon: FontAwesomeIcons.moneyBill, text: price, textStyle: TextDesign().bnbBodyText,),
                    UnCopyableIconText2(icon: Icons.location_on, text: address, textStyle: TextDesign().bnbBodyText,),
                    UnCopyableIconText2(icon: Icons.call, text: phone, textStyle: TextDesign().bnbBodyText,),
                    UnCopyableIconText2(icon: Icons.mail, text: gmail, textStyle: TextDesign().bnbBodyText.copyWith(fontSize: 12)),
                    const SizedBox(height: 5,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
