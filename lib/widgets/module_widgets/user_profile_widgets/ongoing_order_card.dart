
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../const_config/color_config.dart';
import '../../../../const_config/text_config.dart';
import '../../../models/order/user_orders.dart';
import '../../../screens/order_screens/order_details_screen.dart';
import '../../../utils/sd_amount_formate.dart';
import '../../buttons/card_icon_text_button.dart';

class OngoingOrderCard extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final bool isMobileScreen;
  final List<Order> ongoingOrders;

  const OngoingOrderCard(
      {super.key,
        required this.title,
        this.height,
        this.width,
        required this.isMobileScreen, required this.ongoingOrders});

  @override
  Widget build(BuildContext context) {
    return isMobileScreen
        ? InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/OnGoingOrderMobileScreen");
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
              const Icon(Icons.list_alt_rounded),
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
                    const Icon(Icons.list_alt_rounded),
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
                  height ?? (ongoingOrders.length * 50) + 50 + 12,
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
                        label: Text('Pay Status'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Delivery Status'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: Text('Action'),
                        size: ColumnSize.L,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      ongoingOrders.length,
                          (index) => DataRow(
                        cells: [
                          DataCell(Text("#00${ongoingOrders[index].orderId}")),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(ongoingOrders[index].orderDate))),
                          DataCell(Text(
                            ongoingOrders[index].shippingAddress.addressLine1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )),
                          DataCell(Text(sdAmountFormatter(ongoingOrders[index].totalAmount + ongoingOrders[index].totalDeliveryFee))),
                          DataCell(
                            Text(
                              ongoingOrders[index].paymentStatus,
                              style: TextDesign().bnbButtonText.copyWith(
                                color:
                                ongoingOrders[index].paymentStatus ==
                                    'Paid'
                                    ? MyColor.mtMainGreen
                                    : MyColor.red,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              ongoingOrders[index].orderStatus,
                              style: TextDesign().bnbButtonText,
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
                                            orderDate: DateFormat('yyyy-MM-dd').format(ongoingOrders[index].orderDate),
                                            orderStatus: ongoingOrders[index].orderStatus,
                                            payStatus: ongoingOrders[index].paymentStatus,
                                            totalPrice: ongoingOrders[index].totalAmount,
                                            deliveryFee: ongoingOrders[index].totalDeliveryFee,
                                            orderItems: ongoingOrders[index].items,
                                            address: "${ongoingOrders[index].shippingAddress.addressLine1} ${ongoingOrders[index].shippingAddress.addressLine2} ${ongoingOrders[index].shippingAddress.city}  ${ongoingOrders[index].shippingAddress.state} ${ongoingOrders[index].shippingAddress.zipCode}",
                                            orderId: ongoingOrders[index].orderId),
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