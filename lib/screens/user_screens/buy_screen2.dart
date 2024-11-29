
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../models/order/order.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/cart_provider.dart';
import '../../services/order/order_provider.dart';
import '../../services/variant/variant_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/custom_snack_bar.dart';
import '../../widgets/module_widgets/buy_product_widgets/buy_product_card2.dart';
import '../../widgets/module_widgets/buy_product_widgets/payment_card.dart';

class BuyScreen2 extends StatefulWidget {
  const BuyScreen2({super.key});

  @override
  State<BuyScreen2> createState() => _BuyScreen2State();
}

class _BuyScreen2State extends State<BuyScreen2> {
  @override
  void initState() {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);

    order.orderCalculation(CreateOrderRequest(
        userId: 0,
        items: [
          OrderItemRequest(
              productId: variant.cartVariants[0].productId,
              variantId: variant.cartVariants[0].id,
              quantity: cart.buyNowVariantSelectedQuantity),
        ],
        paymentGatewayName: "Cash On Delivery",
        paymentStatus: "pending"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);

    return Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Products:",
                        style: TextDesign()
                            .bnbSubHeaderText
                            .copyWith(fontSize: 16),
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
                              return BuyProductCard2(
                                productImagePath:
                                    "$baseImageUrlProduct/${variantProvider.cartVariants[0].productFirstImage}",
                                productName:
                                    variantProvider.cartVariants[0].variantName,
                                price: cart.buyNowPrice.toString(),
                                color: variantProvider.cartVariants[0].color,
                                productSize:
                                    variantProvider.cartVariants[0].size,
                                quantity: cart.buyNowVariantSelectedQuantity
                                    .toString(),
                                isMobileScreen: true,
                              );
                            }
                          }),
                          Consumer<OrderProvider>(
                              builder: (context, orderProvider, _) {
                                if (orderProvider.orderCalculationIsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor.vdCharcoal,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  );
                                } else {
                                  return PaymentCard(
                                    total: orderProvider.total.toString(),
                                    deliveryFee:
                                    orderProvider.deliveryFee.toString(),
                                    discount:
                                    orderProvider.discount.toString(),
                                    subTotal:
                                    orderProvider.subTotal.toString(),
                                    onClickCOD: () {
                                      if (auth.userLogInStatus) {
                                        order
                                            .createOrder(
                                            CreateOrderRequest(
                                                userId: auth.user.id,
                                                items: [
                                                  OrderItemRequest(
                                                      productId: variant
                                                          .cartVariants[0]
                                                          .productId,
                                                      variantId: variant
                                                          .cartVariants[0]
                                                          .id,
                                                      quantity: cart
                                                          .buyNowVariantSelectedQuantity)
                                                ],
                                                paymentGatewayName:
                                                "Cash On Delivery",
                                                paymentStatus: "pending"),
                                            auth.token)
                                            .then((response) {
                                          CustomSnackBar.showSnackBar(
                                              context: context,
                                              message:
                                              'Order created successfully',
                                              color: MyColor.mtMainGreen);

                                          Navigator.of(context)
                                              .pushNamed('/');
                                        }).catchError((error) {
                                          // Handle error
                                          CustomSnackBar.showSnackBar(
                                              context: context,
                                              message:
                                              'Failed to create order: $error',
                                              color: MyColor.red);
                                        });
                                      } else {
                                        CustomSnackBar.showSnackBar(
                                            context: context,
                                            message:
                                            'To complete order login first',
                                            color: MyColor.red);

                                        Navigator.of(context)
                                            .pushNamed('/LoginScreen');

                                        cart.clearBuyNow();
                                      }
                                    },
                                    onClickPWD: () {},
                                  );
                                }
                              }),
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
