
import 'package:flutter/material.dart';

import '../../../../const_config/text_config.dart';
import '../../../const_config/color_config.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../global_widgets/custome_image_network_card.dart';

class BuyProductCard2 extends StatelessWidget {
  final String productImagePath;
  final String productName;
  final String price;
  final String color;
  final String productSize;
  final String quantity;
  final bool isMobileScreen;
  const BuyProductCard2({
    super.key,
    required this.productImagePath,
    required this.productName,
    required this.price,
    required this.color,
    required this.productSize,
    required this.quantity,
    required this.isMobileScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isMobileScreen
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageNetworkCard(
                      imagePath: productImagePath,
                      imageHeight: 90,
                      imageWidth: 90,
                    ),
                    const SizedBox(width: 5,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextDesign().bnbBodyText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 5,),
                          Text("Color: $color",
                              style: TextDesign()
                                  .bnbBodyText
                                  .copyWith(fontSize: 12)),
                          Text("Quantity: $quantity",
                              style: TextDesign()
                                  .bnbBodyText
                                  .copyWith(fontSize: 12)),
                          Text("Size: $productSize",
                              style: TextDesign()
                                  .bnbBodyText
                                  .copyWith(fontSize: 12)),
                          Text(
                           // "৳ $price",
                            sdAmountFormatter(double.parse(price)),
                            style: TextDesign().bnbBodyText.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,)
          ],
        )
        : SizedBox(
            height: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///for what?
                        // const SizedBox(width: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomImageNetworkCard(
                            imagePath: productImagePath,
                            imageHeight: 100,
                            imageWidth: 120,
                          ),
                        ),
                        SizedBox(
                          width: size.width / 2.23,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextDesign().bnbSubHeaderText.copyWith(fontWeight: FontWeight.w600,fontSize: 18)
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sdAmountFormatter(double.parse(price)),
                                    style: TextDesign().bnbBodyText.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text("Color: $color",
                                      style: TextDesign().bnbBodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  Text("Size: $productSize",
                                      style: TextDesign().bnbBodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  Text("Quantity: $quantity",
                                      style: TextDesign().bnbBodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
