import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const_config/const_config.dart';
import 'package:http/http.dart' as http;

import '../../models/api_call_return.dart';
import '../../models/user/login_user.dart';

class AuthProvider with ChangeNotifier {
  String token = '';
  String status = '';
  String userId = '';
  bool userLogInStatus = false;

  User user = User(
    id: 0,
    name: "",
    phoneNumber: "",
    userType: "",
    email: "",
    emailVerifiedAt: null,
    createdAt: '',
    updatedAt: '',
    address: Address(
        id: 0,
        //  userId: "0",
        addressLine1: "",
        addressLine2: "",
        city: "",
        state: "",
        country: "",
        zipCode: "",
        createdAt: "",
        updatedAt: ""),
  );

  void resentUpdateAddress(Address a) {
    user.address = a;
    notifyListeners();
  }

  void resentUpdateUserProfile(
      {required String name, required String number, required String email}) {
    user.name = name;
    user.phoneNumber = number;
    user.email = email;

    notifyListeners();
  }

  void addUser(User u) {
    user = u;
  }

  void deleteUser() {
    user = User(
      id: 0,
      name: "",
      phoneNumber: "",
      userType: "",
      email: "",
      emailVerifiedAt: null,
      createdAt: '',
      updatedAt: '',
      address: Address(
          id: 0,
          //userId: "0",
          addressLine1: "",
          addressLine2: "",
          city: "",
          state: "",
          country: "",
          zipCode: "",
          createdAt: "",
          updatedAt: ""),
    );
    // notifyListeners();
  }

  void addToken(String t) {
    token = t;
    notifyListeners();
  }

  void deleteToken() {
    token = "";
    notifyListeners();
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);


        if (responseData.containsKey('status') &&
            responseData['status'] == true) {
          addUser(loginUserFromMap(response.body).user);

          addToken(token = responseData['token']);

          status = responseData['message'];

          userLogInStatus = true;

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      // Return false with appropriate message
      return false;
    }
  }

  Future<ApiCallReturn> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String number,
    required String address,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/register');

      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          "phone_number": number,
          "user_type": "customer",
          "address": address
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);


        String message = responseData['message'];
        bool status = responseData['status'];
        String userId =
            responseData['data']['user_id'].toString(); // Convert int to String

        return ApiCallReturn(status: status, message: message, data: [userId]);
      } else {
        // Handle non-200 status codes
        final Map<String, dynamic> responseData = json.decode(response.body);
        String message = responseData['message'];
        return ApiCallReturn(status: false, message: message, data: []);
      }
    } catch (e) {
      return ApiCallReturn(
          status: false, message: 'Failed to connect', data: []);
    }
  }

  Future<bool> forgetPassword(
    String email,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/forgot/password');

      final response = await http.post(
        url,
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if 'status' key exists and is true
        if (responseData.containsKey('status') &&
            responseData['status'] == true) {
          return true;
        } else {

          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(
      {required String token,
      required String password,
      required String confirmPassword}) async {
    try {
      final url = Uri.parse('$baseUrl/reset/password');

      final response = await http.post(
        url,
        body: {
          'token': token,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);


        // Check if 'status' key exists and is true
        if (responseData.containsKey('status') &&
            responseData['status'] == true) {
          // token = responseData['token'];
          // status = responseData['message'];

          return true;
        } else {
          // Return false with appropriate message
          return false;
        }
      } else {
        // Return false with appropriate message
        return false;
      }
    } catch (e) {
      // Return false with appropriate message
      return false;
    }
  }

  Future<bool> logout() async {
    final url = Uri.parse('$baseUrl/logout');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        deleteToken();
        deleteUser();
        userLogInStatus = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
