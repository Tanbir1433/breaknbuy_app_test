import 'package:breaknbuy_app/screens/home.dart';
import 'package:breaknbuy_app/screens/login&signup_screens/forget_password_screen.dart';
import 'package:breaknbuy_app/screens/login&signup_screens/login_screen.dart';
import 'package:breaknbuy_app/screens/login&signup_screens/new_password_screen.dart';
import 'package:breaknbuy_app/screens/login&signup_screens/signup_screen.dart';
import 'package:breaknbuy_app/screens/policy_screen/FAQ_screen.dart';
import 'package:breaknbuy_app/screens/policy_screen/return&refund_policy_screen.dart';
import 'package:breaknbuy_app/screens/policy_screen/terms&conditions_screen.dart';
import 'package:breaknbuy_app/screens/user_profile_screen/ongoing_order_mobile_screen.dart';
import 'package:breaknbuy_app/screens/user_profile_screen/order_history_mobile_screen.dart';
import 'package:breaknbuy_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/buy_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/buy_screen2.dart';
import 'package:breaknbuy_app/screens/user_screens/cart_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/cart_screen_2.dart';
import 'package:breaknbuy_app/screens/user_screens/home_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/product_details_screen.dart';
import 'package:breaknbuy_app/screens/user_screens/reload_screen.dart';
import 'package:breaknbuy_app/services/auth/auth_provider.dart';
import 'package:breaknbuy_app/services/banner/banner_provider.dart';
import 'package:breaknbuy_app/services/bottom_navbar_provider/bottom_navbar.dart';
import 'package:breaknbuy_app/services/cart_provider.dart';
import 'package:breaknbuy_app/services/custom_button_bar_provider.dart';
import 'package:breaknbuy_app/services/image_slider_provider.dart';
import 'package:breaknbuy_app/services/order/order_provider.dart';
import 'package:breaknbuy_app/services/product/product_provider.dart';
import 'package:breaknbuy_app/services/user/user_provider.dart';
import 'package:breaknbuy_app/services/variant/variant_provider.dart';
import 'package:breaknbuy_app/widgets/module_widgets/home_screen_widgets/categories_product_list/all_product.dart';
import 'package:breaknbuy_app/widgets/module_widgets/home_screen_widgets/categories_product_list/discount_product.dart';
import 'package:breaknbuy_app/widgets/module_widgets/home_screen_widgets/categories_product_list/new_arrival.dart';
import 'package:breaknbuy_app/widgets/module_widgets/home_screen_widgets/categories_product_list/recommended_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'const_config/color_config.dart';

void main()  {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ImageSliderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomButtonBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VariantProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BannerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavbarProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      title: 'Break N Buy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.bnbGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/productDetailsScreen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;
          if (args != null && args.containsKey('id')) {
            final productId = args['id'] as int;
            return ProductDetailsScreen(id: productId);
          } else {
            return const ReloadScreen(
              screenName: '/',
            );
          }
        },

        '/BuyScreen': (context) => const BuyScreen(),
        '/BuyScreen2': (context) => const BuyScreen2(),
        '/CartScreen': (context) => const CartScreen(),
        '/CartScreen2': (context) => const CartScreen2(),
        '/UserProfileScreen': (context) => const UserProfileScreen(),
        '/LoginScreen': (context) => const LoginScreen(),
        '/SignUpScreen': (context) => const SignupScreen(),
        '/forgetPasswordScreen': (context) => const ForgetPasswordScreen(),
        '/newPasswordScreen': (context) => const NewPasswordScreen(),
        '/RecommendedProduct': (context) => const RecommendedProduct(),
        '/DiscountProduct': (context) => const DiscountProduct(),
        '/NewArrivalProduct': (context) => const NewArrivalProduct(),
        '/AllProduct': (context) => const AllProduct(),
        '/TermsConditionsScreen': (context) => const TermsConditionsScreen(),
        '/ReturnRefundPolicyScreen': (context) => const ReturnRefundPolicyScreen(),
        '/FAQScreen': (context) => const FAQScreen(),
        '/OnGoingOrderMobileScreen': (context) => const OnGoingOrderMobileScreen(),
        '/OrderHistoryMobileScreen': (context) => const OrderHistoryMobileScreen(),
        //==
      },
    );
  }
}


