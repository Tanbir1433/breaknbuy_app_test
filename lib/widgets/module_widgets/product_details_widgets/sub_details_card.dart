
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../models/product_details/one_product.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/custom_button_bar_provider.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/card_icon_text_button.dart';
import 'custom_color_bar.dart';
import 'custom_size_bar.dart';

class SubDetailsCard extends StatelessWidget {
  final Function cartOnclick;
  final Function buyNowOnClick;
  final ProductDetails product;
  final TextStyle? textStyle;

  const SubDetailsCard(
      {super.key,
      required this.cartOnclick,
      required this.product,
      required this.buyNowOnClick,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final btnBarProvider =
        Provider.of<CustomButtonBarProvider>(context, listen: false);
    // final productP = Provider.of<ProductProvider>(context, listen: false);
    return SizedBox(
      width: 375,
      /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.variants[0].variantName,
              style: TextDesign().bnbHeaderText.copyWith(fontSize: 30),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: double.parse(product.averageRating.toString()),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemSize: 25,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: MyColor.bnbLightRed,
                  ),
                  onRatingUpdate: (rating) {},
                  unratedColor: MyColor.bnbGrey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "(${product.ratingCount} Reviews)",
                  style: TextDesign().bnbBodyText.copyWith(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Material: ${product.materials}',
              style: TextDesign().bnbBodyText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Brand: ${product.brand}',
              style: TextDesign().bnbBodyText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Colors: ',
                  style: TextDesign().bnbBodyText,
                ),
                CustomColorBar(valueList: product.uniqueColors),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sizes: ',
                  style: TextDesign().bnbBodyText,
                ),
                CustomSizeBar(valueList: product.uniqueSizes),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '৳: ${product.variants[0].variantPrice}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextDesign().bnbCardTitleText,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardIconTextButton(
                  onClick: () {
                    cartOnclick();
                  },
                  width: 170,
                  backGroundColor: MyColor.scaffoldColor,
                  buttonTextColor: MyColor.bnbLightBlue,
                  icon: FontAwesomeIcons.cartShopping,
                  iconColor: MyColor.bnbLightBlue,
                  text: 'Add to Cart',
                ),
                CardIconTextButton(
                  width: 170,
                  onClick: () {
                    // buyOnclick();
                    print("clicked");
                    Navigator.of(context).pushNamed('/BuyScreen');
                  },
                  backGroundColor: MyColor.bnbSpaceBlue,
                  icon: Icons.shopping_bag_rounded,
                  text: 'Buy Now',
                ),
              ],
            ),
          ],
        ),*/
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.variants[0].variantName,
              style: textStyle ??
                  TextDesign().bnbHeaderText.copyWith(fontSize: 30),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: double.parse(product.averageRating.toString()),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemSize: 22,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: MyColor.bnbLightRed,
                  ),
                  onRatingUpdate: (rating) {},
                  unratedColor: MyColor.bnbGrey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "(${product.ratingCount} Reviews)",
                  style: TextDesign().bnbBodyText.copyWith(fontSize: 17),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Material: ${product.materials}',
              style: TextDesign().bnbBodyText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Brand:  ${product.brand} ',
              style: TextDesign().bnbBodyText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Colors: ',
                  style: TextDesign().bnbBodyText,
                ),
                CustomColorBar(valueList: product.uniqueColors),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sizes: ',
                  style: TextDesign().bnbBodyText,
                ),
                CustomSizeBar(valueList: product.uniqueSizes),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              sdAmountFormatter(double.parse(product.variants[0].variantPrice.toString())),
              //'৳: ${product.variants[0].variantPrice}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextDesign().bnbCardTitleText,
            ),
            const SizedBox(
              height: 25,
            ),
            CardIconTextButton(
              onClick: () {
                cartOnclick();

                //     product.createCategory(name: 'Bag', description: "Cool bag", token: auth.token);
              },
              width: double.infinity,
              backGroundColor: MyColor.scaffoldColor,
              buttonTextColor: MyColor.bnbLightBlue,
              icon: FontAwesomeIcons.cartShopping,
              iconColor: MyColor.bnbLightBlue,
              text: 'Add to Cart',
            ),
            const SizedBox(
              height: 15,
            ),
            CardIconTextButton(
              width: double.infinity,
              onClick: () {
                /// testing selected color and size value

                buyNowOnClick();
                // Navigator.of(context).pushNamed('/BuyScreen');
              },
              backGroundColor: MyColor.bnbSpaceBlue,
              icon: Icons.shopping_bag_rounded,
              text: 'Buy Now',
            ),
          ],
        ),
      ),
    );
  }
}
