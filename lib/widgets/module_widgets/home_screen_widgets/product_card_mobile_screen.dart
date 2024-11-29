


/*

import 'package:breaknbuy_project/const_config/color_config.dart';
import 'package:breaknbuy_project/const_config/text_config.dart';
import 'package:breaknbuy_project/utils/sd_amount_formate.dart';
import 'package:breaknbuy_project/widgets/global_widgets/custome_image_network_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../buttons/card_icon_text_button.dart';

class ProductCardMobileScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final int id;
  final double? rating;
  final String price;
  final Function cartOnclick;
  final bool isDiscounted;
  final String? oldPrice;
  ProductCardMobileScreen(
      {super.key,
        required this.imagePath,
        required this.title,
        required this.price,
        required this.id,
        required this.cartOnclick,
        required this.isDiscounted,
        this.oldPrice, this.rating});
  final ValueNotifier<bool> isHovering = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (hovering) {
        isHovering.value = hovering;
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/productDetailsScreen', arguments: {
            'id': id,
          });
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: isHovering,
          builder: (context, isHovering, child){
            return Material(
              color: MyColor.white,
              clipBehavior: Clip.hardEdge,
              borderRadius: isHovering ? BorderRadius.circular(15) : BorderRadius.circular(5),
              elevation: isHovering ? 5 : 0,
              child: SizedBox(
                width: 180,
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageNetworkCard(
                          imageHeight: 170, imageWidth: 220, imagePath: imagePath),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: TextDesign().bnbCardTitleTextMobile,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      isDiscounted
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              sdAmountFormatter(double.parse(oldPrice.toString())),
                              //'৳ ${oldPrice ?? '1999'}',
                              style: TextDesign()
                                  .bnbCardTitleTextMobile
                                  .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: MyColor.red,
                                  color: MyColor.red),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              sdAmountFormatter(double.parse(price)),
                              // '৳ $price',
                              style: TextDesign().bnbCardTitleTextMobile,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        sdAmountFormatter(double.parse(price)),
                        style: TextDesign().bnbCardTitleTextMobile,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar.builder(
                        initialRating: rating?? 4,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15,
                        ignoreGestures: true,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CardIconTextButton(
                        onClick: () {
                          cartOnclick();
                        },
                        width: 130,
                        height: 30,
                        backGroundColor: MyColor.bnbLightBlue,
                        buttonTextColor: MyColor.white,
                        icon: FontAwesomeIcons.cartShopping,
                        iconColor: MyColor.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


*/




/// ==== old code don't delete it ======
library;


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/card_icon_text_button.dart';
import '../../global_widgets/custome_image_network_card.dart';

class ProductCardMobileScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final int id;
  final double? rating;
  final String price;
  final Function cartOnclick;
  final bool isDiscounted;
  final String? oldPrice;
  const ProductCardMobileScreen(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.price,
      required this.id,
      required this.cartOnclick,
      required this.isDiscounted,
      this.oldPrice, this.rating});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        hoverColor: MyColor.bnbLightBlue.withOpacity(.3),
        //hoverColor: MyColor.vdDewGreen,
        onTap: () {
          Navigator.of(context).pushNamed('/productDetailsScreen', arguments: {
            'id': id,
          });
        },
        child: SizedBox(
          width: 180,
          height: 332,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageNetworkCard(
                    imageHeight: 170, imageWidth: 220, imagePath: imagePath),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextDesign().bnbCardTitleTextMobile,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                isDiscounted
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              sdAmountFormatter(double.parse(oldPrice??0.toString())),
                            //  '৳ ${oldPrice ?? '1999'}',
                              style: TextDesign()
                                  .bnbCardTitleTextMobile
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: MyColor.red,
                                      color: MyColor.red),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              sdAmountFormatter(double.parse(price)),
                              style: TextDesign().bnbCardTitleTextMobile,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : Text(
                  sdAmountFormatter(double.parse(price)),
                     //   '৳ $price',
                        style: TextDesign().bnbCardTitleTextMobile,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: rating?? 4,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 5,
                ),
                CardIconTextButton(
                  onClick: () {
                    cartOnclick();
                  },
                  width: 130,
                  height: 30,
                  backGroundColor: MyColor.bnbLightBlue,
                  buttonTextColor: MyColor.white,
                  icon: FontAwesomeIcons.cartShopping,
                  iconColor: MyColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
