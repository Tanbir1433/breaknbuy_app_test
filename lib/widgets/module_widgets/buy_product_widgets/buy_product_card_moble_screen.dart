
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../services/cart_provider.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/border_button.dart';
import '../../global_widgets/custome_image_network_card.dart';

class BuyProductCardMobileScreen extends StatefulWidget {
  final String productImagePath;
  final String productName;
  final double price;
  final double bulkPrice;
  final String color;
  final String productSize;
  final bool isMobileScreen;
  final int bulkQuantity;
  final TextEditingController countController;
  final Function cancelCartOnClick;

  const BuyProductCardMobileScreen(
      {super.key,
      required this.productImagePath,
      required this.productName,
      required this.price,
      required this.color,
      required this.productSize,
      required this.isMobileScreen,
      required this.countController,
      required this.bulkQuantity,
      required this.bulkPrice,
      required this.cancelCartOnClick});

  @override
  State<BuyProductCardMobileScreen> createState() =>
      _BuyProductCardMobileScreenState();
}

class _BuyProductCardMobileScreenState
    extends State<BuyProductCardMobileScreen> {
  int counter = 1;

  bool wholesaleActive = false;

  @override
  void initState() {
    super.initState();
    widget.countController.text = counter.toString();
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.buyNowPrice = widget.price;
  }

  void setCounterInController() {
    widget.countController.text = counter.toString();
  }

  void _incrementCounter() {
    if (counter < 10000) {
      setState(() {
        counter++;
      });
    } else {}
  }

  void _decrementCounter() {
    if (wholesaleActive == false && counter > 1) {
      setState(() {
        counter--;
      });
    } else if (wholesaleActive == true && counter > widget.bulkQuantity) {
      setState(() {
        counter--;
      });
    } else {}
  }

  void _setBulkQuantity() {
    setState(() {
      counter = widget.bulkQuantity;
    });
  }

  void buyWholesaleOnClick() {
    _setBulkQuantity();

    wholesaleActive = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return widget.isMobileScreen
        ? Stack(
            children: [
              Column(
                children: [
                  Material(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageNetworkCard(
                            imagePath: widget.productImagePath,
                            imageHeight: 90,
                            imageWidth: 90,
                            boxFit: BoxFit.fitWidth,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextDesign().bnbBodyText.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Color: ${widget.color}",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text("Size: ${widget.productSize}",
                                            style: TextDesign()
                                                .bnbBodyText
                                                .copyWith(fontSize: 14)),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          sdAmountFormatter(
                                              wholesaleActive == false
                                                  ? widget.price
                                                  : widget.bulkPrice),
                                          //"৳ ${wholesaleActive == false ? widget.price : widget.bulkPrice}",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Quantity:",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 28,
                                          width: size.width / 3.6,
                                          child: Material(
                                            color: MyColor.bnbFlashWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                    ),
                                                    onTap: () {
                                                      _decrementCounter();
                                                      setCounterInController();
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  "$counter",
                                                  style: TextDesign()
                                                      .bnbBodyText
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ),
                                                    onTap: () {
                                                      _incrementCounter();
                                                      setCounterInController();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        BorderButton(
                                          height: 28,
                                          width: size.width / 3.6,
                                          onClick: () {
                                            buyWholesaleOnClick();
                                            cart.buyNowPrice = widget.bulkPrice;
                                            setCounterInController();
                                          },
                                          text: 'Wholesale',
                                          textStyle: TextDesign()
                                              .bnbBodyText
                                              .copyWith(fontSize: 10),
                                          icon: FontAwesomeIcons.buyNLarge,
                                          iconSize: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Positioned(
                top: -8,
                right: -5,
                child: IconButton(
                  onPressed: () {
                    widget.cancelCartOnClick();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: MyColor.bnbRed,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Column(
                children: [
                  Material(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageNetworkCard(
                            imagePath: widget.productImagePath,
                            imageHeight: 90,
                            imageWidth: 90,
                            boxFit: BoxFit.fitWidth,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextDesign().bnbBodyText.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Color: ${widget.color}",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text("Size: ${widget.productSize}",
                                            style: TextDesign()
                                                .bnbBodyText
                                                .copyWith(fontSize: 14)),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          sdAmountFormatter(
                                              wholesaleActive == false
                                                  ? widget.price
                                                  : widget.bulkPrice),
                                          //"৳ ${wholesaleActive == false ? widget.price : widget.bulkPrice}",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Quantity:",
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 150,
                                          child: Material(
                                            color: MyColor.bnbFlashWhite,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                    ),
                                                    onTap: () {
                                                      _decrementCounter();
                                                      setCounterInController();
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  "$counter",
                                                  style: TextDesign()
                                                      .bnbBodyText
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ),
                                                    onTap: () {
                                                      _incrementCounter();
                                                      setCounterInController();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BorderButton(
                                          height: 30,
                                          width: 150,
                                          onClick: () {
                                            buyWholesaleOnClick();
                                            cart.buyNowPrice = widget.bulkPrice;
                                            setCounterInController();
                                          },
                                          text: 'Buy Wholesale',
                                          icon: FontAwesomeIcons.buyNLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Positioned(
                top: -8,
                right: -5,
                child: IconButton(
                  onPressed: () {
                    widget.cancelCartOnClick();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: MyColor.bnbRed,
                    size: 20,
                  ),
                ),
              ),
            ],
          );
  }
}

///changed product card
/*
import 'package:breaknbuy_project/const_config/color_config.dart';
import 'package:breaknbuy_project/const_config/text_config.dart';
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
      child: SizedBox(
        width: 180,
        height: 320,
        */
/*width: 260,
        height: 385,*/ /*

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                //hoverColor: MyColor.bnbLightBlue.withOpacity(.3),
                //hoverColor: MyColor.vdDewGreen,
                onTap: () {
                  Navigator.of(context).pushNamed('/productDetailsScreen', arguments: {
                    'id': id,
                  });
                },
                child: Column(
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
                            '৳ ${oldPrice ?? '1999'}',
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
                            '৳ $price',
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      '৳ $price',
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
                  ],
                ),
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
  }
}
*/
