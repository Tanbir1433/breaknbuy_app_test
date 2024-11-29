import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const_config/const_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../models/dash_board/dash_board_product.dart';
import '../../models/product_details/one_product.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> allProducts = [];
  late List<Product> allNewProducts = [];
  late List<Product> allDiscountedProducts = [];
  late List<Product> allRecommendedProducts = [];
  late List<Product> filteredProducts = [];
  late List<Product> relatedProducts = [];

  late bool allProductsIsLoading = false;
  late bool oneProductIsLoading = false;
  late bool relatedProductIsLoading = false;


  late ProductDetails oneProduct = ProductDetails(
      productId: -1,
      description: "",
      categoryId: -1,
      subcategoryId: -1,
      materials: "",
      brand: "",
      isDiscounted: false,
      isRecommended: false,
      isNew: false,
      deliveryFee: 0,
      deliveryTime: "",
      averageRating: 0,
      ratingCount: 0,
      images: [],
      uniqueColors: [],
      uniqueSizes: [],
      variants: [],
      reviews: []);


  bool checkVariantSkuIsValid({required String variantSku}) {
    bool skuFound = false;

    for (final variants in oneProduct.variants) {
      if (variants.variantSku == variantSku) {
        skuFound = true;
        return skuFound;
      }
    }

    return skuFound;
  }

  void addProducts(List<Product> ps) {
    allProducts = ps;
    allNewProducts = [];
    allDiscountedProducts = [];
    allRecommendedProducts = [];

    for (Product p in allProducts) {
      if (p.isDiscounted == 1) {
        print("asi0");
        allDiscountedProducts.add(p);
      }
      if (p.isRecommended == 1) {
        print("asi1");
        allRecommendedProducts.add(p);
      }
      if (p.isNew == 1) {
        print("asi2");
        allNewProducts.add(p);
      }
    }
    notifyListeners();
  }

  void addOneProduct(ProductDetails pd) {
    oneProduct = pd;

    notifyListeners();
  }

  void addRelatedProducts(List<Product> rp){
    relatedProducts = [];
    for (Product p in rp){
      relatedProducts.add(p);
    }
    notifyListeners();
  }

  /// ====================================
  /// ======for searching======
  void filterProducts(String query) {
    if (query.isNotEmpty) {
      filteredProducts = allProducts.where((product) {
        return product.productFirstVariantName
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();

      /// for sorting
      filteredProducts.sort((a, b) {
        final aName = a.productFirstVariantName.toLowerCase();
        final bName = b.productFirstVariantName.toLowerCase();
        final queryLower = query.toLowerCase();
        final aScore = computeRelevance(aName, queryLower);
        final bScore = computeRelevance(bName, queryLower);

        return bScore.compareTo(aScore);
      });
    } else {
      filteredProducts = [];
    }
    notifyListeners();
  }

  /// for computing relevance
  int computeRelevance(String name, String query) {
    if (name.startsWith(query)) {
      return 2;
    } else if (name.contains(query)) {
      return 1;
    } else {
      return 0;
    }
  }

  void clearFilteredProducts() {
    filteredProducts = [];
    notifyListeners();
  }


  ///====================================


  Future<bool> fetchDashboardAllProduct() async {
    allProductsIsLoading = true;
    try {
      final url = Uri.parse('$baseUrl/customer-dashboard/products');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );


      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

print(responseData['message']);

        if (responseData['message'] == 'Products retrieved successfully') {

        ///error_here...
          addProducts(dashBoardProductFromMap(response.body).products);

          notifyListeners();


          allProductsIsLoading = false;
          return true;
        } else {
          notifyListeners();
print('t1');
          allProductsIsLoading = false;
          return false;
        }
      } else {
        notifyListeners();
        allProductsIsLoading = false;
        print('t2');
        return false;
      }
    } catch (e) {
      notifyListeners();
      print('t3');
      allProductsIsLoading = false;

      return false;
    }
  }

  Future<bool> fetchOneProductAllInfo({required int productId}) async {
    oneProductIsLoading = true;
    try {
      final url = Uri.parse('$baseUrl/customer/product/$productId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['message'] ==
            'Product details retrieved successfully') {
          addOneProduct(oneProductFromMap(response.body).productDetails);
          oneProductIsLoading = false;
          return true;
        } else {
          oneProductIsLoading = false;
          return false;
        }
      } else {
        oneProductIsLoading = false;
        return false;
      }
    } catch (e) {
      oneProductIsLoading = false;

      return false;
    }
  }




  Future<bool> fetchRelatedProducts({required int productId}) async {
    relatedProductIsLoading = true;
    try {
      final url = Uri.parse('$baseUrl/customer/products/$productId/related');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['message'] ==
            'Related products retrieved successfully') {
          addRelatedProducts(dashBoardProductFromMap(response.body).products);
          relatedProductIsLoading = false;
          return true;
        } else {
          relatedProductIsLoading = false;
          return false;
        }
      } else {
        relatedProductIsLoading = false;
        return false;
      }
    } catch (e) {
      relatedProductIsLoading = false;

      return false;
    }
  }

}
