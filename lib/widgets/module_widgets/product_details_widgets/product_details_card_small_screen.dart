
import 'package:breaknbuy_app/widgets/module_widgets/product_details_widgets/sub_details_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../services/image_slider_provider.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/const_config.dart';
import '../../../const_config/text_config.dart';
import '../../../models/product_details/one_product.dart';
import '../../../services/cart_provider.dart';
import '../../../services/custom_button_bar_provider.dart';
import '../../../services/product/product_provider.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../global_widgets/custome_image_network_card.dart';
import 'image_click_card.dart';

class ProductDetailsCardSmallScreen extends StatefulWidget {
  final int id;
  final List<String> imageList;
  final ProductDetails product;
  const ProductDetailsCardSmallScreen(
      {super.key,
      required this.id,
      required this.imageList,
      required this.product});

  @override
  State<ProductDetailsCardSmallScreen> createState() =>
      _ProductDetailsCardSmallScreenState();
}

class _ProductDetailsCardSmallScreenState
    extends State<ProductDetailsCardSmallScreen> {
  @override
  void initState() {
    final isp = Provider.of<ImageSliderProvider>(context, listen: false);
    isp.selectedImage = widget.imageList[0];
    isp.smallSelectedImageIndex = 0;
    isp.imageList = widget.imageList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isp = Provider.of<ImageSliderProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    final customButtonBar = Provider.of<CustomButtonBarProvider>(context, listen: false);
    return Material(
      clipBehavior: Clip.hardEdge,
      color: MyColor.white,
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 1030,
        // width: 955,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Image section
            Consumer<ImageSliderProvider>(
              builder: (context, imageSliderProvider, _) {
                return CustomImageNetworkCard(
                  imagePath:
                      "$baseImageUrlProduct/${imageSliderProvider.selectedImage}",
                  imageHeight: 400,
                  imageWidth: 400,
                );
              },
            ),

            const SizedBox(height: 25),

            /// Thumbnails
            size.width > 500
                ? Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: SizedBox(
                      height: 110,
                      child: Consumer<ImageSliderProvider>(
                        builder: (context, imageSliderProvider, _) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageSliderProvider.imageList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ImageClickCard(
                                  imageUrl:
                                      "$baseImageUrlProduct/${imageSliderProvider.imageList[index]}",
                                  onClick: () {
                                    isp.changeSelectedImage(
                                        imageSliderProvider.imageList[index]);
                                    isp.changeSmallSelectedImageIndex(index);
                                  },
                                  isSelected:
                                      isp.smallSelectedImageIndex != index
                                          ? false
                                          : true,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    height: 110,
                    child: Consumer<ImageSliderProvider>(
                      builder: (context, imageSliderProvider, _) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageSliderProvider.imageList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ImageClickCard(
                                imageUrl:
                                    "$baseImageUrlProduct/${imageSliderProvider.imageList[index]}",
                                onClick: () {
                                  isp.changeSelectedImage(
                                      imageSliderProvider.imageList[index]);
                                  isp.changeSmallSelectedImageIndex(index);
                                },
                                isSelected: isp.smallSelectedImageIndex != index
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

            const SizedBox(height: 25),

            /// Details section
            SubDetailsCard(
              textStyle: TextDesign().bnbHeaderText.copyWith(fontSize: 23),
              cartOnclick: () {
                final String sku =
                    "${widget.id}${customButtonBar.selectedColor}${customButtonBar.selectedSize}";

                if (product.checkVariantSkuIsValid(variantSku: sku)) {
                  cart.buyNowVariantSku =
                  "${widget.id}${customButtonBar.selectedColor}${customButtonBar.selectedSize}";

                  customButtonBar.resetSizeColor();

                  cart.addToCartList(variantSku: sku);
                } else {
                  CustomSnackBar.showSnackBar(
                      context: context,
                      message: 'This variant not available',
                      color: MyColor.red);
                }
              },
              product: widget.product,
              buyNowOnClick: () {
                final String sku =
                    "${widget.id}${customButtonBar.selectedColor}${customButtonBar.selectedSize}";

                if (product.checkVariantSkuIsValid(variantSku: sku)) {
                  cart.buyNowVariantSku =
                  "${widget.id}${customButtonBar.selectedColor}${customButtonBar.selectedSize}";

                  customButtonBar.resetSizeColor();

                  Navigator.of(context).pushNamed('/BuyScreen');
                } else {
                  CustomSnackBar.showSnackBar(
                      context: context,
                      message: 'This variant not available',
                      color: MyColor.red);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
