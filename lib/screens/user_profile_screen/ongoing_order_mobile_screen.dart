
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/order/order_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../order_screens/order_details_screen.dart';

class OnGoingOrderMobileScreen extends StatelessWidget {
  const OnGoingOrderMobileScreen({
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
            child: Consumer<OrderProvider>(
                builder: (context, orderProvider, _) {
                  if (orderProvider.ordersIsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColor.bnbGrey,
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  } else if (orderProvider.ordersIsLoading ==
                      false &&
                      orderProvider
                          .ongoingOrderList.isEmpty) {
                    return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'No Orders found',
                            style: TextDesign()
                                .bnbSubHeaderText
                                .copyWith(color: MyColor.textBlack),
                          ),
                        ));
                  } else {
                    return ListView.builder(
                      padding:
                      const EdgeInsets.all(5),
                      itemCount: orderProvider.ongoingOrderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(orderDate: DateFormat('yyyy-MM-dd').format(orderProvider.ongoingOrderList[index].orderDate),
                                            orderStatus: orderProvider.ongoingOrderList[index].orderStatus,
                                            payStatus: orderProvider.ongoingOrderList[index].paymentStatus,
                                            totalPrice: orderProvider.ongoingOrderList[index].totalAmount,
                                            deliveryFee: orderProvider.ongoingOrderList[index].totalDeliveryFee,
                                            orderItems: orderProvider.ongoingOrderList[index].items,
                                            address: "${orderProvider.ongoingOrderList[index].shippingAddress.addressLine1} ${orderProvider.ongoingOrderList[index].shippingAddress.addressLine2} ${orderProvider.ongoingOrderList[index].shippingAddress.city}  ${orderProvider.ongoingOrderList[index].shippingAddress.state} ${orderProvider.ongoingOrderList[index].shippingAddress.zipCode}",
                                            orderId: orderProvider.ongoingOrderList[index].orderId),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date: ${DateFormat('yyyy-MM-dd').format(orderProvider.ongoingOrderList[index].orderDate)} ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "PayStatus: ${orderProvider.ongoingOrderList[index].paymentStatus} ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextDesign().bnbButtonText.copyWith(
                                                  color:
                                                  orderProvider.ongoingOrderList[index].paymentStatus ==
                                                      'Paid'
                                                      ? MyColor.mtMainGreen
                                                      : MyColor.red,
                                                ),
                                              ),
                                              Text(
                                                "DeliveryStatus: ${orderProvider.ongoingOrderList[index].orderStatus}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "OrderId: ${orderProvider.ongoingOrderList[index].orderId} ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Amount: ${orderProvider.ongoingOrderList[index].totalAmount+orderProvider.ongoingOrderList[index].totalDeliveryFee}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Address: ${orderProvider.ongoingOrderList[index].shippingAddress.addressLine1}",
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

