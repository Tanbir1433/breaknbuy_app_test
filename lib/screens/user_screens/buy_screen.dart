
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/cart_provider.dart';
import '../../services/product/product_provider.dart';
import '../../services/variant/variant_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/module_widgets/buy_product_widgets/buy_product_card_moble_screen.dart';
import '../../widgets/module_widgets/buy_product_widgets/order_card.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  /// global key for buy product card
  /*final GlobalKey<BuyProductCardState> buyProductCardKey =
      GlobalKey<BuyProductCardState>();*/

  @override
  void initState() {
    final cart = Provider.of<CartProvider>(context, listen: false);

    /// if use give reload there is e problem. we have to fix it later

    final variant = Provider.of<VariantProvider>(context, listen: false);
    variant.getVariantsAllInfo([(cart.buyNowVariantSku)]);

    super.initState();
  }

  final TextEditingController productCountController = TextEditingController();

  @override
  void dispose() {
    productCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return  Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Products:",
                        style: TextDesign()
                            .bnbSubHeaderText
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<VariantProvider>(
                              builder: (context, variantProvider, _) {
                                if (variantProvider.cartVariantsIsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor.vdCharcoal,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  );
                                } else if (variantProvider
                                    .cartVariantsIsLoading ==
                                    false &&
                                    variantProvider.cartVariants.isEmpty) {
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
                                  return BuyProductCardMobileScreen(
                                    //key: buyProductCardKey,
                                    productImagePath:
                                    "$baseImageUrlProduct/${variantProvider.cartVariants[0].productFirstImage}",
                                    productName: variantProvider
                                        .cartVariants[0].variantName,
                                    price: variantProvider
                                        .cartVariants[0].variantPrice,
                                    bulkPrice:
                                    variantProvider.cartVariants[0].bulkPrice,
                                    bulkQuantity: variantProvider
                                        .cartVariants[0].bulkQuantity,
                                    color: variantProvider.cartVariants[0].color,
                                    productSize:
                                    variantProvider.cartVariants[0].size,
                                    countController: productCountController,
                                    isMobileScreen: true,
                                    cancelCartOnClick: (){},
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                         /*
                          OrderCard(
                            address: auth.userLogInStatus
                                ? " ${auth.user.address.addressLine1}"
                                " ${auth.user.address.state}"
                                " ${auth.user.address.city}"
                                " ${auth.user.address.zipCode}"
                                " ${auth.user.address.country}"
                                : "",
                            deliveryTime: "3-5 days",
                            phone: auth.userLogInStatus
                                ? auth.user.phoneNumber
                                : "",
                            gmail:
                            auth.userLogInStatus ? auth.user.email : "",
                            onclick: () {
                              cart.buyNowVariantSelectedQuantity =
                                  int.parse(productCountController.text);



                              Navigator.pushNamed(context, '/BuyScreen2');
                            },
                          ),*/

                          Consumer<AuthProvider>(
                            builder: (context, auth, _) => OrderCard(
                              address: auth.userLogInStatus
                                  ? "${auth.user.address.addressLine1} "
                                  "${auth.user.address.state} "
                                  "${auth.user.address.city} "
                                  "${auth.user.address.zipCode} "
                                  "${auth.user.address.country}"
                                  : "",
                              deliveryTime: product.oneProduct.deliveryTime,
                              phone: auth.userLogInStatus ? auth.user.phoneNumber : "",
                              gmail: auth.userLogInStatus ? auth.user.email : "",
                              onclick: () {
                                cart.buyNowVariantSelectedQuantity =
                                    int.parse(productCountController.text);



                                Navigator.pushNamed(context, '/BuyScreen2');
                              },
                            ),
                          ),




                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}

/*
class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: MyCard(),
    );
  }
}


class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    int counter = 0;

    void incrementCounter() {
      if (counter < 10000) {
        setState(() {
          counter++;
        });
      }
      else{}
    }

    return SizedBox(
      child: Text(counter.toString()),
    );
  }
}
*/
