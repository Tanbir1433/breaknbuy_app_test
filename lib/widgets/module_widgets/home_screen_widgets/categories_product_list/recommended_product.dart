
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../const_config/color_config.dart';
import '../../../../const_config/const_config.dart';
import '../../../../const_config/text_config.dart';
import '../../../../services/product/product_provider.dart';
import '../../../appbar/bnb_app_bar.dart';
import '../../../global_widgets/section_banner_header.dart';
import '../product_card_mobile_screen.dart';

class RecommendedProduct extends StatefulWidget {
  const RecommendedProduct({super.key});

  @override
  State<RecommendedProduct> createState() => _RecommendedProductState();
}

class _RecommendedProductState extends State<RecommendedProduct> {

  @override
  void initState() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.fetchDashboardAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: SectionBannerHeader(
                      text: "RECOMMENDED",
                      imagePath: "assets/images/star.png",
                      textStyle:
                          TextDesign().bnbBannerText.copyWith(color: MyColor.bnbGrey),
                      isRight: false,
                      isMobileScreen: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ProductProvider>(
                      builder: (context, productProvider, _) {
                        if (productProvider.allProductsIsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyColor.vdCharcoal,
                              strokeCap: StrokeCap.round,
                            ),
                          );
                        } else
                        if (productProvider.allProductsIsLoading ==
                            false &&
                            productProvider.allRecommendedProducts
                                .isEmpty) {
                          return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No Recommended Product found',
                                  style: TextDesign()
                                      .vdSubHeaderText
                                      .copyWith(
                                      color: MyColor.textBlack),
                                ),
                              ));
                        } else {
                          return Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 15,
                              runSpacing: 15,
                              direction: Axis.horizontal,
                              children: productProvider
                                  .allRecommendedProducts
                                  .map((item) {
                                return ProductCardMobileScreen(
                                  cartOnclick: () {
                                    // cartProvider.addToCart(item);
                                  },
                                  oldPrice: item.price.toString(),
                                  rating: double.parse(
                                      item.averageRatingValue
                                          .toString()),
                                  imagePath:
                                  '$baseImageUrlProduct/${item
                                      .firstImage}',
                                  title: item.productFirstVariantName,
                                  price: item.isDiscounted == 0
                                      ? item.price.toString()
                                      : item.discountPrice.toString(),
                                  isDiscounted:
                                  item.isDiscounted == 0 ? false : true,
                                  id: item.productId,
                                );
                              }).toList(),
                            ),
                          );
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
