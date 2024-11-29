// To parse this JSON data, do
//
//     final cartVariants = cartVariantsFromMap(jsonString);

import 'dart:convert';

CartVariants cartVariantsFromMap(String str) => CartVariants.fromMap(json.decode(str));

String cartVariantsToMap(CartVariants data) => json.encode(data.toMap());

class CartVariants {
  bool success;
  String message;
  List<CartVariant> data;

  CartVariants({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CartVariants.fromMap(Map<String, dynamic> json) => CartVariants(
    success: json["success"],
    message: json["message"],
    data: List<CartVariant>.from(json["data"].map((x) => CartVariant.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class CartVariant {
  int id;
  int productId;
  String variantName;
  double variantPrice;
  int variantStockQuantity;
  String variantSku;
  String color;
  String size;
  double discountedPrice;
  double bulkPrice;
  int bulkQuantity;
  String productFirstImage;

  CartVariant({
    required this.id,
    required this.productId,
    required this.variantName,
    required this.variantPrice,
    required this.variantStockQuantity,
    required this.variantSku,
    required this.color,
    required this.size,
    required this.discountedPrice,
    required this.bulkPrice,
    required this.bulkQuantity,
    required this.productFirstImage,
  });

  factory CartVariant.fromMap(Map<String, dynamic> json) => CartVariant(
    id: json["id"],
    productId: json["ProductID"],
    variantName: json["VariantName"],
    variantPrice: json["VariantPrice"],
    variantStockQuantity: json["VariantStockQuantity"],
    variantSku: json["VariantSKU"],
    color: json["Color"],
    size: json["Size"],
    discountedPrice: json["DiscountedPrice"],
    bulkPrice: json["BulkPrice"],
    bulkQuantity: json["BulkQuantity"],
    productFirstImage: json["ProductFirstImage"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ProductID": productId,
    "VariantName": variantName,
    "VariantPrice": variantPrice,
    "VariantStockQuantity": variantStockQuantity,
    "VariantSKU": variantSku,
    "Color": color,
    "Size": size,
    "DiscountedPrice": discountedPrice,
    "BulkPrice": bulkPrice,
    "BulkQuantity": bulkQuantity,
    "ProductFirstImage": productFirstImage,
  };
}
