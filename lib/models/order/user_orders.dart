import 'dart:convert';

UserOrdersResponse userOrdersResponseFromMap(String str) => UserOrdersResponse.fromMap(json.decode(str));
String userOrdersResponseToMap(UserOrdersResponse data) => json.encode(data.toMap());

class UserOrdersResponse {
  List<Order> orders;

  UserOrdersResponse({
    required this.orders,
  });

  factory UserOrdersResponse.fromMap(Map<String, dynamic> json) => UserOrdersResponse(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
  };
}

class Order {
  int orderId;
  String orderStatus;
  double totalAmount;
  double totalDeliveryFee;
  DateTime orderDate;
  String paymentStatus;
  ShippingAddress shippingAddress;
  List<OrderItem> items;

  Order({
    required this.orderId,
    required this.orderStatus,
    required this.totalAmount,
    required this.totalDeliveryFee,
    required this.orderDate,
    required this.paymentStatus,
    required this.shippingAddress,
    required this.items,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    orderId: json["order_id"],
    orderStatus: json["order_status"],
    totalAmount: json["total_amount"].toDouble(),
    totalDeliveryFee: json["total_delivery_fee"].toDouble(),
    orderDate: DateTime.parse(json["order_date"]),
    paymentStatus: json["payment_status"],
    shippingAddress: ShippingAddress.fromMap(json["shipping_address"]),
    items: List<OrderItem>.from(json["items"].map((x) => OrderItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "order_status": orderStatus,
    "total_amount": totalAmount,
    "total_delivery_fee": totalDeliveryFee,
    "order_date": orderDate.toIso8601String(),
    "payment_status": paymentStatus,
    "shipping_address": shippingAddress.toMap(),
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class ShippingAddress {
  int id;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String zipCode;

  ShippingAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
    id: json["id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
  };
}

class OrderItem {
  int productId;
  String imageUrl;
  int variantId;
  int quantity;
  double unitPrice;
  int bulkQuantity;
  String variantName;
  String variantSize;
  String variantColor;

  OrderItem({
    required this.productId,
    required this.imageUrl,
    required this.variantId,
    required this.quantity,
    required this.unitPrice,
    required this.bulkQuantity,
    required this.variantName,
    required this.variantSize,
    required this.variantColor,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
    productId: json["product_id"],
    imageUrl: json["image_url"],
    variantId: json["variant_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"].toDouble(),
    bulkQuantity: json["bulk_quantity"],
    variantName: json["variant_name"],
    variantSize: json["variant_size"],
    variantColor: json["variant_color"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "image_url": imageUrl,
    "variant_id": variantId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "bulk_quantity": bulkQuantity,
    "variant_name": variantName,
    "variant_size": variantSize,
    "variant_color": variantColor,
  };
}
