
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/auth/auth_provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../services/cart_provider.dart';
import 'accounts_orders_widget.dart';
import 'bnb_search_bar.dart';

class BnbAppBar extends StatelessWidget {
  final bool isHome;

  const BnbAppBar({
    super.key,
    required this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    return  Material(
        color: Colors.white,
        elevation: 1,
        child: SizedBox(
          height: 132,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isHome
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: MyColor.bnbRed,
                            ),
                          ),
                    // Image.asset("assets/images/logo02.jpeg",width: 40,height: 40,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'break',
                            style: TextDesign().bnbSubHeaderText,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'n',
                                style: TextDesign()
                                    .bnbSubHeaderText
                                    .copyWith(color: MyColor.bnbRed),
                              ),
                              TextSpan(
                                text: 'buy',
                                style: TextDesign().bnbSubHeaderText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return authProvider.token == ''
                          ? SizedBox(
                              width: 110,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/LoginScreen');
                                    },
                                    child: Text("Login",
                                        style: TextDesign().mtBodyText.copyWith(
                                            backgroundColor: MyColor.white)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/SignUpScreen');
                                    },
                                    child: Text("SignUp",
                                        style: TextDesign().mtBodyText.copyWith(
                                            backgroundColor: MyColor.white)),
                                  ),
                                ],
                              ),
                            )
                          : const AccountsOrdersWidget();
                    }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// ===========search bar===================
                    const Expanded(
                      child: BnbSearchBar(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/CartScreen');
                          },
                          child: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -15, end: -12),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: MyColor.bnbRed,
                            ),
                            badgeContent: Text(
                              cartProvider.cartListVariantSku.length.toString(),
                              style: TextDesign()
                                  .bnbBodyText
                                  .copyWith(color: MyColor.white, fontSize: 12),
                            ),
                            badgeAnimation: const badges.BadgeAnimation.scale(
                              animationDuration: Duration(seconds: 1),
                            ),
                            child: const Icon(Icons.shopping_cart),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
