
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../models/order/user_orders.dart';
import '../../services/auth/auth_provider.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/text_row_with_header.dart';
import '../../widgets/module_widgets/footer_widgets/icon_text.dart';
import '../../widgets/module_widgets/user_profile_widgets/user_rating_popup.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;
  final String orderDate;
  final String orderStatus;
  final String payStatus;
  final double totalPrice;
  final double deliveryFee;
  final List<OrderItem> orderItems;
  final String address;

  const OrderDetailsScreen({
    super.key,
    required this.orderItems,
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.payStatus,
    required this.deliveryFee,
    required this.totalPrice,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    double priceWithQuantity(double price, int quantity) {
      return price * quantity;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.bnbFlashWhite,
      body: Column(
        children: [
          const Flexible(
              flex: 0,
              child: BnbAppBar(
                isHome: false,
              )),
          Flexible(
            flex: 1,
            child:  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              TextRowWithHeader(
                                  bodyText: '#00$orderId',
                                  headerText: "Order Id"),
                              TextRowWithHeader(
                                  bodyText: orderDate,
                                  headerText: "Order Date"),
                              TextRowWithHeader(
                                  bodyText: orderStatus,
                                  headerText: "Order Status"),
                              TextRowWithHeader(
                                  bodyText: payStatus,
                                  headerText: "Pay Status"),
                              const SizedBox(
                                height: 10,
                                //child: Divider(),
                              ),
                              SizedBox(
                                height: (orderItems.length * 120) + 12,
                                child: DataTable2(
                                  dataRowHeight: 110,
                                  headingTextStyle: TextDesign().mtTableHeading,
                                  columnSpacing: 10,
                                  horizontalMargin: 10,
                                  minWidth: 940,
                                  clipBehavior: Clip.antiAlias,
                                  dataTextStyle:
                                      TextDesign().bnbButtonText.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                  columns: const [
                                    DataColumn2(
                                      label: Text('Items'),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      label: Text('Quantity'),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(''),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text('Price'),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text('Total'),
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text('Rating'),
                                      size: ColumnSize.S,
                                    )
                                  ],
                                  rows: List<DataRow>.generate(
                                    orderItems.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextRowWithHeader(
                                                bodyText: orderItems[index]
                                                    .variantName,
                                                headerText: "Product"),
                                            TextRowWithHeader(
                                                bodyText: orderItems[index]
                                                    .variantColor,
                                                headerText: "Color"),
                                            TextRowWithHeader(
                                                bodyText: orderItems[index]
                                                    .variantSize,
                                                headerText: "Size"),
                                          ],
                                        )),
                                        DataCell(Text(orderItems[index]
                                            .quantity
                                            .toString())),
                                        DataCell(Text(
                                          'X',
                                          style: TextDesign()
                                              .bnbBodyText
                                              .copyWith(
                                                  color:
                                                      MyColor.textLightBlack),
                                        )),
                                        DataCell(Text(orderItems[index]
                                            .unitPrice
                                            .toString())),
                                        DataCell(
                                          Text(
                                            priceWithQuantity(
                                              orderItems[index].unitPrice,
                                              orderItems[index].quantity,
                                            ).toString(),
                                          ),
                                        ),
                                        DataCell(IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return UserRatingPopup(
                                                    productId: orderItems[index]
                                                        .productId,
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.commentDots,
                                            size: 20,
                                            color: MyColor.bnbRed,
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                child: Divider(),
                              ),
                              TextRowWithHeader(
                                  bodyText: totalPrice.toString(),
                                  headerText: "Total"),
                              TextRowWithHeader(
                                  bodyText: deliveryFee.toString(),
                                  headerText: "Delivery Fee"),
                              TextRowWithHeader(
                                  bodyText:
                                      (totalPrice + deliveryFee).toString(),
                                  headerText: "Sub-Total"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            child: SizedBox(
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    IconText(
                                      icon: Icons.person,
                                      text: "Customer Information",
                                      textStyle: TextDesign().bnbSubHeaderText,
                                    ),
                                    TextRowWithHeader(
                                        bodyText: auth.user.name,
                                        headerText: "Name"),
                                    TextRowWithHeader(
                                        bodyText: auth.user.phoneNumber,
                                        headerText: "Phone"),
                                    TextRowWithHeader(
                                        bodyText: auth.user.email,
                                        headerText: "Email"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            child: SizedBox(
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    IconText(
                                      icon: Icons.house_siding_rounded,
                                      text: "Delivery Address",
                                      textStyle: TextDesign().bnbSubHeaderText,
                                    ),
                                    TextRowWithHeader(
                                        bodyText: address,
                                        headerText: "Full Address"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
