// To parse this JSON data, do
//
//     final oneProduct = oneProductFromMap(jsonString);

import 'dart:convert';

OneProduct oneProductFromMap(String str) =>
    OneProduct.fromMap(json.decode(str));

String oneProductToMap(OneProduct data) => json.encode(data.toMap());

class OneProduct {
  String message;
  ProductDetails productDetails;

  OneProduct({
    required this.message,
    required this.productDetails,
  });

  factory OneProduct.fromMap(Map<String, dynamic> json) => OneProduct(
        message: json["message"],
        productDetails: ProductDetails.fromMap(json["productDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "productDetails": productDetails.toMap(),
      };
}

class ProductDetails {
  int productId;
  String description;
  int categoryId;
  int subcategoryId;
  String materials;
  String brand;
  bool isDiscounted;
  bool isRecommended;
  bool isNew;
  int deliveryFee;
  String deliveryTime;
  int averageRating;
  int ratingCount;
  List<String> images;
  List<String> uniqueColors;
  List<String> uniqueSizes;
  List<Variant> variants;
  List<Review> reviews;

  ProductDetails({
    required this.productId,
    required this.description,
    required this.categoryId,
    required this.subcategoryId,
    required this.materials,
    required this.brand,
    required this.isDiscounted,
    required this.isRecommended,
    required this.isNew,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.averageRating,
    required this.ratingCount,
    required this.images,
    required this.uniqueColors,
    required this.uniqueSizes,
    required this.variants,
    required this.reviews,
  });

  factory ProductDetails.fromMap(Map<String, dynamic> json) => ProductDetails(
        productId: json["product_id"],
        description: json["description"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        materials: json["materials"],
        brand: json["brand"],
        isDiscounted: json["is_discounted"],
        isRecommended: json["is_recommended"],
        isNew: json["is_new"],
        deliveryFee: json["delivery_fee"],
        deliveryTime: json["delivery_time"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        images: List<String>.from(json["images"].map((x) => x)),
        uniqueColors: List<String>.from(json["unique_colors"].map((x) => x)),
        uniqueSizes: List<String>.from(json["unique_sizes"].map((x) => x)),
        variants:
            List<Variant>.from(json["variants"].map((x) => Variant.fromMap(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "description": description,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "materials": materials,
        "brand": brand,
        "is_discounted": isDiscounted,
        "is_recommended": isRecommended,
        "is_new": isNew,
        "delivery_fee": deliveryFee,
        "delivery_time": deliveryTime,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "images": List<dynamic>.from(images.map((x) => x)),
        "unique_colors": List<dynamic>.from(uniqueColors.map((x) => x)),
        "unique_sizes": List<dynamic>.from(uniqueSizes.map((x) => x)),
        "variants": List<dynamic>.from(variants.map((x) => x.toMap())),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
      };
}

class Review {
  int reviewId;
  String userName;
  int ratingValue;
  String? review;

  Review({
    required this.reviewId,
    required this.userName,
    required this.ratingValue,
    this.review,
  });

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        reviewId: json["review_id"],
        userName: json["user_name"],
        ratingValue: json["rating_value"],
        review: json["review"],
      );

  Map<String, dynamic> toMap() => {
        "review_id": reviewId,
        "user_name": userName,
        "rating_value": ratingValue,
        "review": review,
      };
}

class Variant {
  int variantId;
  String variantName;
  int variantPrice;
  int stockQuantity;
  String variantSku;
  String color;
  String size;
  int? discountedPrice;
  int? bulkPrice;
  int? bulkQuantity;

  Variant({
    required this.variantId,
    required this.variantName,
    required this.variantPrice,
    required this.stockQuantity,
    required this.variantSku,
    required this.color,
    required this.size,
    this.discountedPrice,
    this.bulkPrice,
    this.bulkQuantity,
  });

  factory Variant.fromMap(Map<String, dynamic> json) => Variant(
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        variantPrice: json["variant_price"],
        stockQuantity: json["stock_quantity"],
        variantSku: json["variant_sku"],
        color: json["color"],
        size: json["size"],
        discountedPrice: json["discounted_price"],
        bulkPrice: json["bulk_price"],
        bulkQuantity: json["bulk_quantity"],
      );

  Map<String, dynamic> toMap() => {
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_price": variantPrice,
        "stock_quantity": stockQuantity,
        "variant_sku": variantSku,
        "color": color,
        "size": size,
        "discounted_price": discountedPrice,
        "bulk_price": bulkPrice,
        "bulk_quantity": bulkQuantity,
      };
}
