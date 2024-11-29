import 'package:flutter/material.dart';
import '../models/dash_board/dash_board_product.dart';

class CartProvider extends ChangeNotifier {

  /// use for buy now===========
  late String buyNowVariantSku = '';
  late int buyNowVariantSelectedQuantity = 0;
  late double buyNowPrice = 0;

  void clearBuyNow() {
    buyNowVariantSku = '';
    buyNowVariantSelectedQuantity = 0;
    buyNowPrice = 0;
    notifyListeners();
  }

  /// use for cart ===================

  late List<String> cartListVariantSku = [];
  late List<int> cartListVariantsQuantity = [];

  void clearCartListALl() {
    cartListVariantSku = [];
    cartListVariantsQuantity = [];
    notifyListeners();
  }



  void cancelCart({required String variantSku}){

    cartListVariantSku.removeWhere((item)=> item==variantSku);
    notifyListeners();

}

  void addToCartList({required String variantSku}) {
    if (!cartListVariantSku.contains(variantSku)) {
      cartListVariantSku.add(variantSku);
      notifyListeners();
    } else {
    }
  }

  void removeAddToCartList() {
    cartListVariantSku = [];
  }

  void removeBuyNowVariantSku() {
    buyNowVariantSku = '';
  }

  ///===========================================
  List<Product> cartItems = [];

  List<Product> get getCartItems => cartItems;

  int get cartCount => cartItems.length;

  void addToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }
}
