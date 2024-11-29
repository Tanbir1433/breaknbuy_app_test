
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/order/order_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/footer.dart';
import '../../widgets/module_widgets/user_profile_widgets/address_card.dart';
import '../../widgets/module_widgets/user_profile_widgets/ongoing_order_card.dart';
import '../../widgets/module_widgets/user_profile_widgets/order_history_card.dart';
import '../../widgets/module_widgets/user_profile_widgets/personal_profile_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final order = Provider.of<OrderProvider>(context, listen: false);

    if (auth.userLogInStatus) {
      order.fetchUserOrders(userId: auth.user.id, token: auth.token);
    } else {
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: MyColor.bnbFlashWhite,
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
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Consumer<AuthProvider>(
                            builder: (context, auth, _) => PersonalProfileCard(
                              name: auth.userLogInStatus ? auth.user.name : "",
                              email:
                                  auth.userLogInStatus ? auth.user.email : "",
                              phone: auth.userLogInStatus
                                  ? auth.user.phoneNumber
                                  : "",

                              address: '',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<AuthProvider>(
                            builder: (context, auth, _) => AddressCard(
                              address: auth.userLogInStatus
                                  ? "${auth.user.address.addressLine1} "
                                      "${auth.user.address.state} "
                                      "${auth.user.address.city} "
                                      "${auth.user.address.zipCode} "
                                      "${auth.user.address.country}"
                                  : "",
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const OngoingOrderCard(
                            title: "Ongoing Orders",
                            isMobileScreen: true,
                            ongoingOrders: [],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const OrderHistoryCard(
                            title: "Order History",
                            isMobileScreen: true,
                            orderHistories: [],
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
      );
  }
}
