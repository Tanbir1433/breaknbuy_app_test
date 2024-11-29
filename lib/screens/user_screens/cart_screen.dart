
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../models/order/cart_variants.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/cart_provider.dart';
import '../../services/variant/variant_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/module_widgets/buy_product_widgets/buy_product_card_moble_screen.dart';
import '../../widgets/module_widgets/buy_product_widgets/order_card.dart';

///Code..with..wrap
/*class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<TextEditingController> productCountControllers = [];

  @override
  void initState() {
    super.initState();
    final cart = Provider.of<CartProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);
    variant.getVariantsAllInfo(cart.cartListVariantSku);

    // Initialize the controllers
    productCountControllers =
        List.generate(cart.cartListVariantSku.length, (index) => TextEditingController());
  }

  void storeQuantity(List<CartVariant> cvls) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.cartListVariantsQuantity = List.generate(
        cvls.length, (index) => int.parse(productCountControllers[index].text));

    for (var controller in productCountControllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    for (var controller in productCountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);
    return ResponsiveLayout(
      largeScreen: Scaffold(
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
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cart Products:",
                            style: TextDesign().bnbSubHeaderText,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Consumer<VariantProvider>(
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
                                        return Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 5,
                                          runSpacing: 5,
                                          direction: Axis.vertical,
                                          children: variantProvider.cartVariants
                                              .map((item) {
                                            return BuyProductCard(
                                              productImagePath:
                                              '$baseImageUrlProduct/${item.productFirstImage}',
                                              productName: item.variantName,
                                              price: item.variantPrice,
                                              bulkPrice: item.bulkPrice,
                                              bulkQuantity: item.bulkQuantity,
                                              color: item.color,
                                              productSize:item.size,
                                              countController: TextEditingController(text: variantProvider.cartVariants.length.toString()),
                                            );
                                          }).toList(),
                                        );
                                      }
                                    }),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: OrderCard(
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
                                    storeQuantity(variant.cartVariants);
                                    Navigator.pushNamed(context, '/CartScreen2');
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const Footer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      mediumScreen: Scaffold(
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart Products:",
                        style: TextDesign().bnbSubHeaderText,
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
                                  return SizedBox(
                                    height: double.parse((145 *
                                        variantProvider.cartVariants.length)
                                        .toString()),
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: variantProvider.cartVariants.length,
                                      itemBuilder: (context, index) {
                                        return BuyProductCardMobileScreen(
                                          productImagePath:
                                          "$baseImageUrlProduct/${variantProvider.cartVariants[index].productFirstImage}",
                                          productName: variantProvider
                                              .cartVariants[index].variantName,
                                          price: variantProvider
                                              .cartVariants[index].variantPrice,
                                          bulkPrice: variantProvider
                                              .cartVariants[index].bulkPrice,
                                          bulkQuantity: variantProvider
                                              .cartVariants[index].bulkQuantity,
                                          color: variantProvider
                                              .cartVariants[index].color,
                                          productSize: variantProvider
                                              .cartVariants[index].size,
                                          countController:
                                          productCountControllers[index],
                                          isMobileScreen: false,
                                        );
                                      },
                                    ),
                                  );
                                }
                              }),
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
                              storeQuantity(variant.cartVariants);
                              Navigator.pushNamed(context, '/CartScreen2');
                            },
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
      ),
      smallScreen: Scaffold(
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
                  padding: const EdgeInsets.all(05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart Products:",
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
                                  return SizedBox(
                                    height: double.parse((125 *
                                        variantProvider.cartVariants.length)
                                        .toString()),
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: variantProvider.cartVariants.length,
                                      itemBuilder: (context, index) {
                                        return BuyProductCardMobileScreen(
                                          productImagePath:
                                          "$baseImageUrlProduct/${variantProvider.cartVariants[index].productFirstImage}",
                                          productName: variantProvider
                                              .cartVariants[index].variantName,
                                          price: variantProvider
                                              .cartVariants[index].variantPrice,
                                          bulkPrice: variantProvider
                                              .cartVariants[index].bulkPrice,
                                          bulkQuantity: variantProvider
                                              .cartVariants[index].bulkQuantity,
                                          color: variantProvider
                                              .cartVariants[index].color,
                                          productSize: variantProvider
                                              .cartVariants[index].size,
                                          countController:
                                          productCountControllers[index],
                                          isMobileScreen: true,
                                        );
                                      },
                                    ),
                                  );
                                }
                              }),
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
                              storeQuantity(variant.cartVariants);
                              Navigator.pushNamed(context, '/CartScreen2');
                            },
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
      ),
    );
  }
}*/
///Code..with..Listview
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<TextEditingController> productCountControllers = [];

  @override
  void initState() {
    super.initState();
    final cart = Provider.of<CartProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);
    variant.getVariantsAllInfo(cart.cartListVariantSku);

    // Initialize the controllers
    productCountControllers = List.generate(
        cart.cartListVariantSku.length, (index) => TextEditingController());
  }

  void storeQuantity(List<CartVariant> cvls) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.cartListVariantsQuantity = List.generate(
        cvls.length, (index) => int.parse(productCountControllers[index].text));

    for (var controller in productCountControllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    for (var controller in productCountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final auth = Provider.of<AuthProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);
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
                  padding: const EdgeInsets.all(05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart Products:",
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
                            } else if (variantProvider.cartVariantsIsLoading ==
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
                              return SizedBox(
                                height: double.parse(
                                    (125 * variantProvider.cartVariants.length)
                                        .toString()),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      variantProvider.cartVariants.length,
                                  itemBuilder: (context, index) {
                                    return BuyProductCardMobileScreen(
                                      productImagePath:
                                          "$baseImageUrlProduct/${variantProvider.cartVariants[index].productFirstImage}",
                                      productName: variantProvider
                                          .cartVariants[index].variantName,
                                      price: variantProvider
                                          .cartVariants[index].variantPrice,
                                      bulkPrice: variantProvider
                                          .cartVariants[index].bulkPrice,
                                      bulkQuantity: variantProvider
                                          .cartVariants[index].bulkQuantity,
                                      color: variantProvider
                                          .cartVariants[index].color,
                                      productSize: variantProvider
                                          .cartVariants[index].size,
                                      countController:
                                          productCountControllers[index],
                                      isMobileScreen: true,
                                      cancelCartOnClick: () {
                                        cart.cancelCart(
                                            variantSku: variantProvider
                                                .cartVariants[index]
                                                .variantSku);

                                        variantProvider.clearCartVariant(
                                            vId: variantProvider
                                                .cartVariants[index].id);
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                          }),

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
                            gmail: auth.userLogInStatus ? auth.user.email : "",
                            onclick: () {
                              storeQuantity(variant.cartVariants);
                              Navigator.pushNamed(context, '/CartScreen2');
                            },
                          ),
                          */
                          Consumer<AuthProvider>(
                            builder: (context, auth, _) => OrderCard(
                              address: auth.userLogInStatus
                                  ? "${auth.user.address.addressLine1} "
                                      "${auth.user.address.state} "
                                      "${auth.user.address.city} "
                                      "${auth.user.address.zipCode} "
                                      "${auth.user.address.country}"
                                  : "",
                              deliveryTime: "1 week Max",
                              phone: auth.userLogInStatus
                                  ? auth.user.phoneNumber
                                  : "",
                              gmail:
                                  auth.userLogInStatus ? auth.user.email : "",
                              onclick: () {
                                storeQuantity(variant.cartVariants);
                                Navigator.pushNamed(context, '/CartScreen2');
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
