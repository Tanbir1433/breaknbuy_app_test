import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const_config/const_config.dart';
import 'package:http/http.dart' as http;
import '../../models/order/cart_variants.dart';

class VariantProvider with ChangeNotifier {
  late List<CartVariant> cartVariants = [];

  late bool cartVariantsIsLoading = false;

  void addCartVariants(List<CartVariant> cvs) {
    cartVariants = [];
    cartVariants = cvs;
    notifyListeners();
  }

  void clearCartVariant({required int vId}) {
    cartVariants.removeWhere((item) => item.id == vId);
    notifyListeners();
  }


  void clearAllCartVariants(){
    cartVariants=[];
    notifyListeners();
  }

  Future<bool> getVariantsAllInfo(List<String> variantSKUs) async {
    cartVariantsIsLoading = true;
    final url = Uri.parse('$baseUrl/variants/details');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'variant_skus': variantSKUs,
        }),
      );

      if (response.statusCode == 200) {
        addCartVariants(cartVariantsFromMap(response.body).data);
        cartVariantsIsLoading = false;

        return true;
      } else {
        cartVariantsIsLoading = false;
        notifyListeners();

        return false;
      }
    } catch (e) {
      cartVariantsIsLoading = false;

      return false;
    }
  }
}
