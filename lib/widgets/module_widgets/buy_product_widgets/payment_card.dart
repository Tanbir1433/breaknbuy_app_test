
import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/border_button.dart';
import '../../buttons/simple_button.dart';
import 'add_promo_popup.dart';

class PaymentCard extends StatelessWidget {
  final String total;
  final String deliveryFee;
  final String discount;
  final String subTotal;
  final Function onClickCOD;
  final Function onClickPWD;
  const PaymentCard({
    super.key,
    required this.total,
    required this.deliveryFee,
    required this.discount,
    required this.subTotal,
    required this.onClickCOD,
    required this.onClickPWD,
  });

  @override
  Widget build(BuildContext context) {
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
              "Payment Details",
              style: TextDesign().bnbSubHeaderText,
            )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextDesign().bnbBodyText,
                      ),
                      Text(
                        sdAmountFormatter(double.parse(total)),
                        //"৳ $total",
                        style: TextDesign().bnbBodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextDesign().bnbBodyText,
                      ),
                      Text(
                        sdAmountFormatter(double.parse(deliveryFee)),
                        //"৳ $deliveryFee",
                        style: TextDesign().bnbBodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount:",
                        style: TextDesign().bnbBodyText,
                      ),
                      Text(
                        sdAmountFormatter(double.parse(discount)),
                        // "৳ $discount",
                        style: TextDesign().bnbBodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub-Total:",
                        style: TextDesign().bnbBodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                      Text(
                        sdAmountFormatter(double.parse(subTotal)),
                        //"৳ $subTotal",
                        style: TextDesign().bnbBodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Center(
                child: BorderButton(
              onClick: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddPromoPopUp();
                    });
              },
              text: "Add Promo",
              icon: Icons.discount_rounded,
              width: 130,
            )),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: SimpleButton(
              onClick: onClickCOD,
              text: "Cash on Delivery",
              backGroundColor: MyColor.bnbFlashWhite,
              width: 200,
              buttonTextColor: MyColor.bnbSpaceBlue,
            )),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: SimpleButton(
              onClick: onClickPWD,
              text: "Pay with Bkash",
              backGroundColor: MyColor.bnbRed,
              width: 200,
            )),
          ],
        ),
      ),
    );
  }
}
