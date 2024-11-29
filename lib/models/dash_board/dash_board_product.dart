// To parse this JSON data, do
//
//     final dashBoardProduct = dashBoardProductFromMap(jsonString);

import 'dart:convert';

DashBoardProduct dashBoardProductFromMap(String str) => DashBoardProduct.fromMap(json.decode(str));

String dashBoardProductToMap(DashBoardProduct data) => json.encode(data.toMap());

class DashBoardProduct {
  String message;
  List<Product> products;

  DashBoardProduct({
    required this.message,
    required this.products,
  });

  factory DashBoardProduct.fromMap(Map<String, dynamic> json) =>
      DashBoardProduct(
        message: json["message"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  int productId;
  int firstVariantId;
  String firstVariantSku;
  String productFirstVariantName;
  int averageRatingValue;
  String firstImage;
  double price;
  double discountPrice;
  int isNew;
  int isRecommended;
  int isDiscounted;

  Product({
    required this.productId,
    required this.firstVariantId,
    required this.firstVariantSku,
    required this.productFirstVariantName,
    required this.averageRatingValue,
    required this.firstImage,
    required this.price,
    required this.discountPrice,
    required this.isNew,
    required this.isRecommended,
    required this.isDiscounted,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        firstVariantId: json["first_variant_id"],
        productFirstVariantName: json["product_first_variant_name"],
        averageRatingValue: json["average_rating_value"],
        firstImage: json["first_image"],
        price: json["price"],
        discountPrice: json["discount_price"],
        isNew: json["is_new"],
        isRecommended: json["is_recommended"],
        isDiscounted: json["is_discounted"],
        firstVariantSku: json["first_variant_sku"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "first_variant_id": firstVariantId,
        "first_variant_sku": firstVariantSku,
        "product_first_variant_name": productFirstVariantName,
        "average_rating_value": averageRatingValue,
        "first_image": firstImage,
        "price": price,
        "discount_price": discountPrice,
        "is_new": isNew,
        "is_recommended": isRecommended,
        "is_discounted": isDiscounted,
      };
}
