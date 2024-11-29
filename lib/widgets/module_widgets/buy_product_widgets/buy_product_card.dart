
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../const_config/text_config.dart';
import '../../../const_config/color_config.dart';
import '../../../services/cart_provider.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/border_button.dart';
import '../../global_widgets/custome_image_network_card.dart';

class BuyProductCard extends StatefulWidget {
  final String productImagePath;
  final String productName;
  final double price;
  final double bulkPrice;
  final String color;
  final String productSize;
  final int bulkQuantity;
  final TextEditingController countController;
  final Function cancelCartOnClick;

  const BuyProductCard({
    super.key,
    required this.productImagePath,
    required this.productName,
    required this.price,
    required this.color,
    required this.productSize,
    required this.bulkQuantity,
    required this.bulkPrice,
    required this.countController,
    required this.cancelCartOnClick,
  });

  @override
  State<BuyProductCard> createState() => _BuyProductCardState();
}

class _BuyProductCardState extends State<BuyProductCard> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Material(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomImageNetworkCard(
                          imagePath: widget.productImagePath,
                          imageHeight: 110,
                          imageWidth: 110,
                          boxFit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          width: size.width / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextDesign().bnbSubHeaderText.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sdAmountFormatter(wholesaleActive == false
                                        ? widget.price
                                        : widget.bulkPrice),
                                    //"৳ ${wholesaleActive == false ? widget.price : widget.bulkPrice}",
                                    style: TextDesign().bnbBodyText.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text("Color: ${widget.color}",
                                      style: TextDesign().bnbBodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  Text("Size: ${widget.productSize}",
                                      style: TextDesign().bnbBodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity:",
                              style: TextDesign()
                                  .bnbBodyText
                                  .copyWith(fontSize: 12),
                            ),
                            SizedBox(
                              height: 35,
                              width: 160,
                              child: Material(
                                color: MyColor.bnbFlashWhite,
                                borderRadius: BorderRadius.circular(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        child: const Icon(Icons.remove),
                                        onTap: () {
                                          _decrementCounter();
                                          setCounterInController();
                                        },
                                      ),
                                    ),
                                    Text("$counter"),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        child: const Icon(Icons.add),
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
                              onClick: () {
                                buyWholesaleOnClick();
                                cart.buyNowPrice = widget.bulkPrice;
                                setCounterInController();
                              },
                              text: 'Buy Wholesale',
                              icon: FontAwesomeIcons.buyNLarge,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

/*class BuyProductCard extends StatefulWidget {
  final String productImagePath;
  final String productName;
  final double price;
  final double bulkPrice;
  final String color;
  final String productSize;
  final int bulkQuantity;
  final TextEditingController countController;

  const BuyProductCard({
    super.key,
    required this.productImagePath,
    required this.productName,
    required this.price,
    required this.color,
    required this.productSize,
    required this.bulkQuantity,
    required this.bulkPrice,
    required this.countController,
  });

  @override
  State<BuyProductCard> createState() => _BuyProductCardState();
}

class _BuyProductCardState extends State<BuyProductCard> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close_rounded,
                        color: MyColor.bnbRed,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomImageNetworkCard(
                      imagePath: widget.productImagePath,
                      imageHeight: 110,
                      imageWidth: 110,
                      boxFit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: size.width / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextDesign().bnbSubHeaderText.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "৳ ${wholesaleActive == false ? widget.price : widget.bulkPrice}",
                                style: TextDesign().bnbBodyText.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text("Color: ${widget.color}",
                                  style: TextDesign().bnbBodyText.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                              Text("Size: ${widget.productSize}",
                                  style: TextDesign().bnbBodyText.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity:",
                          style:
                              TextDesign().bnbBodyText.copyWith(fontSize: 12),
                        ),
                        SizedBox(
                          height: 35,
                          width: 160,
                          child: Material(
                            color: MyColor.bnbFlashWhite,
                            borderRadius: BorderRadius.circular(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    child: const Icon(Icons.remove),
                                    onTap: () {
                                      _decrementCounter();
                                      setCounterInController();
                                    },
                                  ),
                                ),
                                Text("$counter"),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    child: const Icon(Icons.add),
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
                          onClick: () {
                            buyWholesaleOnClick();
                            cart.buyNowPrice = widget.bulkPrice;
                            setCounterInController();
                          },
                          text: 'Buy Wholesale',
                          icon: FontAwesomeIcons.buyNLarge,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}*/
