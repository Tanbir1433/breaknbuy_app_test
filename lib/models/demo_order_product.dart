class DemoOrderProduct {
  int productId;
  int variantId;
  String productName;
  String variantName;
  String variantColor;
  String variantSize;
  double variantPrice;
  double variantDiscount;
  double bulkDiscount;
  double promoDiscount;
  double priceAfterDiscount;
  int quantity;

  DemoOrderProduct({
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.variantColor,
    required this.variantSize,
    required this.variantPrice,
    required this.variantDiscount,
    required this.bulkDiscount,
    required this.promoDiscount,
    required this.priceAfterDiscount,
    required this.quantity,
  });
}
