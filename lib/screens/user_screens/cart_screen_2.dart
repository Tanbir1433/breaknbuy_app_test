
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../models/order/cart_variants.dart';
import '../../models/order/order.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/cart_provider.dart';
import '../../services/order/order_provider.dart';
import '../../services/variant/variant_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/custom_snack_bar.dart';
import '../../widgets/module_widgets/buy_product_widgets/buy_product_card2.dart';
import '../../widgets/module_widgets/buy_product_widgets/payment_card.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({super.key});

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  @override
  void initState() {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);

    List<OrderItemRequest> getCartItem(
        {required List<String> cartList,
        required List<CartVariant> cartVariant,
        required List<int> cartQuantity}) {
      return List.generate(
          cartList.length,
          (index) => OrderItemRequest(
              productId: cartVariant[index].productId,
              variantId: cartVariant[index].id,
              quantity: cartQuantity[index]));
    }

    order.orderCalculation(CreateOrderRequest(
        userId: 0,
        items: getCartItem(
            cartList: cart.cartListVariantSku,
            cartVariant: variant.cartVariants,
            cartQuantity: cart.cartListVariantsQuantity),
        paymentGatewayName: "Cash On Delivery",
        paymentStatus: "pending"));

    super.initState();
  }

  List<OrderItemRequest> getCartItem(
      {required List<String> cartList,
      required List<CartVariant> cartVariant,
      required List<int> cartQuantity}) {
    return List.generate(
        cartList.length,
        (index) => OrderItemRequest(
            productId: cartVariant[index].productId,
            variantId: cartVariant[index].id,
            quantity: cartQuantity[index]));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final variant = Provider.of<VariantProvider>(context, listen: false);

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
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart Products:",
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
                                  height: double.parse((130 *
                                          variantProvider.cartVariants.length)
                                      .toString()),
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          variantProvider.cartVariants.length,
                                      itemBuilder: (context, index) {
                                        // Check if the cartListVariantsQuantity list is not empty and has the required index
                                        if (index <
                                            cart.cartListVariantsQuantity
                                                .length) {
                                          return BuyProductCard2(
                                            productImagePath:
                                                "$baseImageUrlProduct/${variantProvider.cartVariants[index].productFirstImage}",
                                            productName: variantProvider
                                                .cartVariants[index]
                                                .variantName,
                                            price: variantProvider
                                                .cartVariants[index]
                                                .variantPrice
                                                .toString(),
                                            color: variantProvider
                                                .cartVariants[index].color,
                                            productSize: variantProvider
                                                .cartVariants[index].size,
                                            quantity: cart
                                                .cartListVariantsQuantity[index]
                                                .toString(),
                                            isMobileScreen: true,
                                          );
                                        } else {
                                          return const SizedBox
                                              .shrink(); // Return an empty container or handle the case where index is out of bounds
                                        }
                                      }),
                                );
                              }
                            },
                          ),
                          Consumer<OrderProvider>(
                              builder: (context, orderProvider, _)  {

                                if(orderProvider.orderCalculationIsLoading){

                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor.vdCharcoal,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  );
                                }else{
                                  return PaymentCard(
                                    total: orderProvider.total.toString(),
                                    deliveryFee: orderProvider.deliveryFee.toString(),
                                    discount: orderProvider.discount.toString(),
                                    subTotal: orderProvider.subTotal.toString(),
                                    onClickCOD: () {
                                      if (auth.userLogInStatus) {
                                        orderProvider
                                            .createOrder(
                                            CreateOrderRequest(
                                                userId: auth.user.id,
                                                items: getCartItem(
                                                    cartList: cart
                                                        .cartListVariantSku,
                                                    cartVariant:
                                                    variant.cartVariants,
                                                    cartQuantity: cart
                                                        .cartListVariantsQuantity),
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

                                          Navigator.of(context).pushNamed('/');
                                          cart.clearCartListALl();
                                          variant.clearAllCartVariants();

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
                                      }
                                    },
                                    onClickPWD: () {},
                                  );
                                }

                              }
                          )
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
