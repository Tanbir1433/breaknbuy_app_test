import 'dart:convert';

import 'package:flutter/material.dart';
import '../../const_config/const_config.dart';
import 'package:http/http.dart' as http;
import '../../models/order/order.dart';
import '../../models/order/user_orders.dart';

class OrderProvider with ChangeNotifier {
  late List<Order> allOrders = [];
  late bool ordersIsLoading = false;
  late List<Order> orderHistoryList = [];
  late List<Order> ongoingOrderList = [];

  /// use for order calculation
  late double total = 0;
  late double deliveryFee = 0;
  late double discount = 0;
  late double subTotal = 0;

  late bool orderCalculationIsLoading = false;

  void addCalculation({
    required double total,
    required double deliveryFee,
    required double discount,
    required double subTotal,
  }) {
    this.total = total;
    this.deliveryFee = deliveryFee;
    this.discount = discount;
    this.subTotal = subTotal;

    notifyListeners();
  }

  void addOrders(List<Order> or) {
    allOrders = or;
    orderFilterForHistory(allOrders);
    notifyListeners();
  }

  void orderFilterForHistory(List<Order> or) {
    ongoingOrderList = [];
    orderHistoryList = [];
    for (Order x in or) {
      if (x.orderStatus == 'completed') {
        orderHistoryList.add(x);
      } else {
        ongoingOrderList.add(x);
      }
    }
    notifyListeners();
  }

  Future<OrderResponse> createOrder(
      CreateOrderRequest orderRequest, String token) async {
    final url = Uri.parse('$baseUrl/orders/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderRequest.toJson()),
      );

      if (response.statusCode == 201) {
        return OrderResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create order: ${response.body}');
      }
    } catch (e) {
      throw Exception('An error occurred while creating the order: $e');
    }
  }

  Future<bool> orderCalculation(CreateOrderRequest orderRequest) async {
    orderCalculationIsLoading = true;
    final url = Uri.parse('$baseUrl/orders/calculate');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderRequest.toJson()),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        addCalculation(
            total: responseBody['total_amount'],
            deliveryFee: responseBody['total_delivery_fee'],
            discount: responseBody['discount_price'],
            subTotal: responseBody['sub_total']);

        orderCalculationIsLoading = false;

        return true;
      } else {
        orderCalculationIsLoading = false;

        return false;
      }
    } catch (e) {
      orderCalculationIsLoading = false;

      return false;
    }
  }

  /// fetching all orders

  /*Future<bool> fetchUserOrders({required int userId, required String token}) async {
    ordersIsLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/users/$userId/orders');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final orders = userOrdersResponseFromMap(response.body).orders;
        if (orders.isNotEmpty) {
          addOrders(orders);
        } else {
          print('No orders found for this user');
          allOrders = [];
        }
        ordersIsLoading = false;
        notifyListeners();
        return true;
      } else {
        ordersIsLoading = false;
        allOrders = [];
        notifyListeners();
        print('Failed to fetch orders: ${response.body}');
        return false;
      }
    } catch (e) {
      ordersIsLoading = false;
      allOrders = [];
      notifyListeners();
      print('An error occurred while fetching orders: $e');
      return false;
    }
  }*/

  Future<bool> fetchUserOrders(
      {required int userId, required String token}) async {
    ordersIsLoading = true;

    try {
      final url = Uri.parse('$baseUrl/users/$userId/orders');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        addOrders(userOrdersResponseFromMap(response.body).orders);

        ordersIsLoading = false;
        return true;
      } else {
        ordersIsLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      ordersIsLoading = false;
      notifyListeners();
      return false;
    }
  }
}
