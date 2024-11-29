import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const_config/const_config.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Future<bool> createAddress({
    required int userId,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    final url = Uri.parse('$baseUrl/addresses');

    try {
      final response = await http.post(
        url,
        body: {
          "user_id": userId.toString(), // Convert int to string
          'address_line1': addressLine1,
          'address_line2': addressLine2,
          'city': city,
          'state': state,
          'country': country,
          'zipcode': zipCode,
        },
      );


      if (response.statusCode == 201) {
        // Check for 201 Created status code
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateAddress({
    required String token,
    required int id,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    final url = Uri.parse('$baseUrl/addresses/$id');

    final Map<String, dynamic> updateData = {
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'zip_code': zipCode,
    };

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateUserProfile({
    required String token,
    required int id,
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$baseUrl/users/$id/upadte-info');

    final Map<String, dynamic> updateData = {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    };

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> storeRating(
      {required String token,
      required int userId,
      required int productId,
      required int ratingValue,
      String? review}) async {
    final url = Uri.parse('$baseUrl/ratings');

    final requestBody = {
      'UserID': userId.toString(),
      'ProductID': productId.toString(),
      'RatingValue': ratingValue.toString(),
      if (review != null) 'Review': review,
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      // Handle API errors appropriately
      return false;
    }
  }
}
