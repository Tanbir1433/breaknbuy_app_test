
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../services/banner/banner_provider.dart';
import '../../services/cart_provider.dart';
import '../../services/product/product_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/footer.dart';
import '../../widgets/global_widgets/section_banner_header.dart';
import '../../widgets/module_widgets/home_screen_widgets/product_card_mobile_screen.dart';
import '../../widgets/module_widgets/home_screen_widgets/top_banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    final product = Provider.of<ProductProvider>(context, listen: false);
    final banner = Provider.of<BannerProvider>(context, listen: false);
   // banner.fetchBanners();
    product.fetchDashboardAllProduct().then((onValue){

      if(onValue){
        print('hhh');

      }else{
        print('llll');
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return  Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColor.bnbScaffold,
        body: Column(
          children: [
            const Flexible(
              flex: 0,
              child: BnbAppBar(
                isHome: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return const SizedBox(
                            height: 10,
                          );
                        } else if (index == 1) {
                          return Text('');
                            // Consumer<BannerProvider>(
                            //   builder: (context, bannerProvider, child) {
                            //     if (bannerProvider.bannersIsLoading) {
                            //       //print("Tanbir${bannerProvider.banners}");
                            //       return const Center(child: CircularProgressIndicator());
                            //     }
                            //     return TopBannerCarousel(widgetList: bannerProvider.banners.map((banner) {
                            //       //print("Tanbir${banner.title}");
                            //       return Material(
                            //         clipBehavior: Clip.hardEdge,
                            //         color: MyColor.bnbScaffold,
                            //         borderRadius: BorderRadius.circular(5),
                            //         child: Image.network('$baseImageUrlBanners/${banner.imagePath}'), // Assuming imageUrl is the property name
                            //       );
                            //     }).toList(),
                            //       height: 120,
                            //     );
                            //   },
                            // );
                        } else if (index == 2) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SectionBannerHeader(
                              text: "RECOMMENDED",
                              imagePath: "assets/images/star.png",
                              textStyle: TextDesign().bnbBannerText.copyWith(
                                  color: MyColor.bnbGrey, fontSize: 23),
                              mediumScreenImgWidth: 150,
                              isRight: false,
                              isMobileScreen: true,
                            ),
                          );
                        } else if (index == 3) {
                          return Consumer<ProductProvider>(
                              builder: (context, productProvider, child) {
                            if (productProvider.allProductsIsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MyColor.vdCharcoal,
                                  strokeCap: StrokeCap.round,
                                ),
                              );
                            } else if (productProvider.allProductsIsLoading == false && productProvider.allRecommendedProducts.isEmpty) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No  Recommended Product found',
                                  style: TextDesign()
                                      .vdSubHeaderText
                                      .copyWith(color: MyColor.textBlack),
                                ),
                              ));
                            } else {
                              return Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  spacing: 15,
                                  runSpacing: 15,
                                  direction: Axis.horizontal,
                                  children: productProvider.allRecommendedProducts.map((item) {

                                    return ProductCardMobileScreen(
                                      cartOnclick: () {
                                        //  cartProvider.addToCart(item);
                                        cart.addToCartList(variantSku: item.firstVariantSku);
                                      },
                                      oldPrice: item.price.toString(),
                                      rating: double.parse(item.averageRatingValue.toString()),
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
                          });
                        } else if (index == 4) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SectionBannerHeader(
                              text: "DISCOUNTED",
                              imagePath: "assets/images/home/discount.png",
                              textStyle: TextDesign().bnbBannerText.copyWith(
                                    color: MyColor.red,
                                    fontSize: 23,
                                  ),
                              isRight: true,
                              isMobileScreen: true,
                            ),
                          );
                        } else if (index == 5) {
                          return Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            if (productProvider.allProductsIsLoading) {
                              return SizedBox(
                                height: size.height,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor.vdCharcoal,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                              );
                            } else if (productProvider.allProductsIsLoading ==
                                    false &&
                                productProvider.allDiscountedProducts.isEmpty) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No Discounted Product found',
                                  style: TextDesign()
                                      .vdSubHeaderText
                                      .copyWith(color: MyColor.textBlack),
                                ),
                              ));
                            } else {
                              return Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  spacing: 15,
                                  runSpacing: 15,
                                  direction: Axis.horizontal,
                                  children: productProvider
                                      .allDiscountedProducts
                                      .map((item) {
                                    return ProductCardMobileScreen(
                                      cartOnclick: () {
                                        //  cartProvider.addToCart(item);
                                        cart.addToCartList(
                                            variantSku: item.firstVariantSku);
                                      },
                                      oldPrice: item.price.toString(),
                                      rating: double.parse(
                                          item.averageRatingValue.toString()),
                                      imagePath:
                                          '$baseImageUrlProduct/${item.firstImage}',
                                      title: item.productFirstVariantName,
                                      price: item.discountPrice.toString(),
                                      isDiscounted:
                                          item.isDiscounted == 0 ? false : true,
                                      id: item.productId,
                                    );
                                  }).toList());
                            }
                          });
                        } else if (index == 6) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SectionBannerHeader(
                              text: "NEW COLLECTION",
                              imagePath: "assets/images/home/new_arrival.png",
                              textStyle: TextDesign().bnbBannerText.copyWith(
                                  color: MyColor.bnbLightRed, fontSize: 22),
                              isRight: false,
                              isMobileScreen: true,
                            ),
                          );
                        } else if (index == 7) {
                          return Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            if (productProvider.allProductsIsLoading) {
                              return SizedBox(
                                height: size.height,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColor.vdCharcoal,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                              );
                            } else if (productProvider.allProductsIsLoading ==
                                    false &&
                                productProvider.allNewProducts.isEmpty) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'No  New Product found',
                                  style: TextDesign()
                                      .vdSubHeaderText
                                      .copyWith(color: MyColor.textBlack),
                                ),
                              ));
                            } else {
                              return Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  spacing: 15,
                                  runSpacing: 15,
                                  direction: Axis.horizontal,
                                  children: productProvider.allNewProducts
                                      .map((item) {
                                    return ProductCardMobileScreen(
                                      cartOnclick: () {
                                        //  cartProvider.addToCart(item);
                                        cart.addToCartList(
                                            variantSku: item.firstVariantSku);
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
                          });
                        } else if (index == 8) {
                          return Text(
                            "All Products",
                            style: TextDesign().bnbSubHeaderText,
                          );
                        } else if (index == 9) {
                          return Consumer<ProductProvider>(
                              builder: (context, productProvider, _) {
                            if (productProvider.allProductsIsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MyColor.vdCharcoal,
                                  strokeCap: StrokeCap.round,
                                ),
                              );
                            } else if (productProvider.allProductsIsLoading ==
                                    false &&
                                productProvider.allProducts.isEmpty) {
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
                              return Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  spacing: 15,
                                  runSpacing: 15,
                                  direction: Axis.horizontal,
                                  children:
                                      productProvider.allProducts.map((item) {
                                    return ProductCardMobileScreen(
                                      cartOnclick: () {
                                        //  cartProvider.addToCart(item);
                                        cart.addToCartList(
                                            variantSku: item.firstVariantSku);
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
                          });
                        } else if (index == 10) {
                          return const Footer();
                        } else {
                          throw Error();
                        }
                      },
                      childCount: 11,
                    ),
                  ),
                ],
              ),

              ///=======================================
            ),
          ],
        ),
      );
  }
}
