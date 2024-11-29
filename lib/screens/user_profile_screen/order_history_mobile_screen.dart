
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/order/order_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/buttons/card_icon_text_button.dart';

class OrderHistoryMobileScreen extends StatelessWidget {
  const OrderHistoryMobileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            child:
                Consumer<OrderProvider>(builder: (context, orderProvider, _) {
              if (orderProvider.ordersIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: MyColor.bnbGrey,
                    strokeCap: StrokeCap.round,
                  ),
                );
              } else if (orderProvider.ordersIsLoading == false &&
                  orderProvider.orderHistoryList.isEmpty) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'No Order History found',
                    style: TextDesign()
                        .bnbSubHeaderText
                        .copyWith(color: MyColor.textBlack),
                  ),
                ));
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, right: 5, bottom: 5),
                  itemCount: orderProvider.orderHistoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        elevation: 1,
                        color: MyColor.white,
                        borderRadius: BorderRadius.circular(5),
                        child: Column(
                          children: [
                            Material(
                              color: MyColor.bnbLightBlue,
                              child: SizedBox(
                                height: 10,
                                width: size.width,
                              ),
                            ),
                            /*InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const OrderDetailsScreen(orderId: 420, orderItems: [],),
                                        ),
                                      );

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Material(
                                            color: MyColor.bnbLightBlue,
                                            borderRadius: BorderRadius.circular(5),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 14),
                                              child: Text(
                                                "Details",
                                                style: TextDesign()
                                                    .bnbBodyText
                                                    .copyWith(color: MyColor.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date: ${DateFormat('yyyy-MM-dd').format(orderProvider.orderHistoryList[index].orderDate)}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          orderProvider.orderHistoryList[index]
                                                      .paymentStatus ==
                                                  ''
                                              ? CardIconTextButton(
                                                  onClick: () {},
                                                  height: 30,
                                                  backGroundColor: Colors.amber,
                                                  buttonTextColor:
                                                      MyColor.white,
                                                  icon:
                                                      Icons.rate_review_rounded,
                                                  iconColor: MyColor.white,
                                                  text: "Rate!",
                                                )
                                              : Text(
                                                  "rating: ${orderProvider.orderHistoryList[index].paymentStatus}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          Text(
                                            "review: ${orderProvider.orderHistoryList[index].paymentStatus} ",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Oid: ${orderProvider.orderHistoryList[index].orderId} ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Amount: ${orderProvider.orderHistoryList[index].totalAmount + orderProvider.orderHistoryList[index].totalDeliveryFee}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Address: ${orderProvider.orderHistoryList[index].shippingAddress.addressLine1}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
