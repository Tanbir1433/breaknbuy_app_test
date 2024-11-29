
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../const_config/color_config.dart';
import '../../../../const_config/text_config.dart';
import '../../../models/order/user_orders.dart';
import '../../../screens/order_screens/order_details_screen.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/card_icon_text_button.dart';

class OrderHistoryCard extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final List<Order> orderHistories;
  final bool isMobileScreen;
  const OrderHistoryCard(
      {super.key,
        required this.title,
        this.height,
        this.width,
        required this.isMobileScreen, required this.orderHistories,});

  @override
  Widget build(BuildContext context) {
    return isMobileScreen
        ? InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/OrderHistoryMobileScreen");
      },
      child: Material(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style:
                TextDesign().bnbSubHeaderText.copyWith(fontSize: 16),
              ),
              const Icon(Icons.history_rounded),
            ],
          ),
        ),
      ),
    )
        : Material(
          clipBehavior: Clip.hardEdge,
          color: MyColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: MyColor.vdOxfordBlue, width: 1),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),

                /// card Title ======
                Row(
                  children: [
                    const Icon(Icons.history_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: TextDesign().bnbSubHeaderText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                /// table start  here ===============

                SizedBox(
                  height:
                  height ?? (orderHistories.length * 50) + 50 + 12,
                  child: DataTable2(
                    dataRowHeight: 50,
                    headingTextStyle: TextDesign().mtTableHeading,
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 940,
                    clipBehavior: Clip.antiAlias,
                    dataTextStyle: TextDesign().mtTableText,
                    columns: const [
                      DataColumn2(
                        label: Text('Order ID'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Order date'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Address'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('Amount'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Review'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Rating'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: Text('Action'),
                        size: ColumnSize.L,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      orderHistories.length,
                          (index) => DataRow(
                        cells: [
                          DataCell(Text("#00${orderHistories[index].orderId}")),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(orderHistories[index].orderDate))),
                          DataCell(Text(
                            orderHistories[index].shippingAddress.addressLine1,
                            maxLines: 3,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          DataCell(Text(sdAmountFormatter(orderHistories[index].totalAmount + orderHistories[index].totalDeliveryFee))),
                          /*DataCell(Text("${orderHistories[index].totalAmount + orderHistories[index].totalDeliveryFee}")),*/
                          DataCell(
                            Text(orderHistories[index].paymentStatus),
                          ),
                          DataCell(
                            ///for rating == to be added
                            orderHistories[index].paymentStatus == ''
                                ? CardIconTextButton(
                              onClick: () {},
                              height: 30,
                              backGroundColor: Colors.amber,
                              buttonTextColor: MyColor.white,
                              icon: Icons.rate_review_rounded,
                              iconColor: MyColor.white,
                              text: "Rate!",
                            )
                                : Text(
                              orderHistories[index].paymentStatus,
                            ),
                          ),
                          DataCell(
                            CardIconTextButton(
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailsScreen(
                                            orderDate: DateFormat('yyyy-MM-dd').format(orderHistories[index].orderDate),
                                            orderStatus: orderHistories[index].orderStatus,
                                            payStatus: orderHistories[index].paymentStatus,
                                            totalPrice: orderHistories[index].totalAmount,
                                            deliveryFee: orderHistories[index].totalDeliveryFee,
                                            orderItems: orderHistories[index].items,
                                            address: orderHistories[index].shippingAddress.addressLine1,
                                            orderId: orderHistories[index].orderId),
                                  ),
                                );
                              },
                              height: 30,
                              backGroundColor: MyColor.bnbLightBlue,
                              buttonTextColor: MyColor.white,
                              icon: Icons.view_in_ar_rounded,
                              iconColor: MyColor.white,
                              text: "View",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
