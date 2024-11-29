import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/custom_button_bar_provider.dart';
import '../../services/product/product_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/footer.dart';
import '../../widgets/module_widgets/home_screen_widgets/product_card_mobile_screen.dart';
import '../../widgets/module_widgets/product_details_widgets/product_details_card_small_screen.dart';
import '../../widgets/module_widgets/product_details_widgets/product_description_card.dart';
import '../../widgets/module_widgets/product_details_widgets/products_review_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    final customButtonBar =
        Provider.of<CustomButtonBarProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.fetchOneProductAllInfo(productId: widget.id).then((value) {
      if (value) {
        customButtonBar.setSelectedColor(product.oneProduct.variants[0].color);
        customButtonBar.setSelectedSize(product.oneProduct.variants[0].size);
      }
    });
    product.fetchRelatedProducts(productId: widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColor.bnbScaffold,
      body: Column(
        children: [
          const Flexible(
            flex: 0,
            child: BnbAppBar(
              isHome: false,
            ),
          ),
          Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            if (productProvider.oneProductIsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MyColor.vdCharcoal,
                                  strokeCap: StrokeCap.round,
                                ),
                              );
                            } else if (productProvider.oneProductIsLoading ==
                                    false &&
                                productProvider.oneProduct.productId == -1) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No Product found',
                                  style: TextDesign()
                                      .vdSubHeaderText
                                      .copyWith(color: MyColor.textBlack),
                                ),
                              ));
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: ProductDetailsCardSmallScreen(
                                  id: widget.id,
                                  imageList: productProvider.oneProduct.images,
                                  product: productProvider.oneProduct,
                                ),
                              );
                            }
                          }),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            return ProductsReviewCard(
                              reviews: productProvider.oneProduct.reviews,
                            );
                          }),
                          const SizedBox(
                            height: 7,
                          ),
                          const ProductDescriptionCard(
                            description: '',
                          ),
                          const SizedBox(
                            height: 7,
                          ),

                          /// == suggested product list =====
                          Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            if (productProvider.relatedProductIsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MyColor.bnbGrey,
                                  strokeCap: StrokeCap.round,
                                ),
                              );
                            } else if (productProvider
                                        .relatedProductIsLoading ==
                                    false &&
                                productProvider.relatedProducts.isEmpty) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No  Related Product found',
                                  style: TextDesign()
                                      .bnbSubHeaderText
                                      .copyWith(color: MyColor.textBlack),
                                ),
                              ));
                            } else {
                              return Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  spacing: 15,
                                  runSpacing: 15,
                                  direction: Axis.horizontal,
                                  children: productProvider.relatedProducts
                                      .map((item) {
                                    return ProductCardMobileScreen(
                                      cartOnclick: () {
                                        //  cartProvider.addToCart(item);
                                      },
                                      oldPrice: item.price.toString(),
                                      rating: double.parse(
                                          item.averageRatingValue.toString()),
                                      imagePath:
                                          '$baseImageUrlProduct/${item.firstImage}',
                                      title: item.productFirstVariantName,
                                      price: item.isDiscounted == 0
                                          ? item.price.toString()
                                          : item.discountPrice.toString(),
                                      isDiscounted:
                                          item.isDiscounted == 0 ? false : true,
                                      id: item.productId,
                                    );
                                  }).toList());
                            }
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const Footer(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
