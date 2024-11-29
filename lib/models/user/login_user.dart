// To parserequired this JSON data, do
//
//     final loginUser = loginUserFromMap(jsonString);

import 'dart:convert';

LoginUser loginUserFromMap(String str) => LoginUser.fromMap(json.decode(str));

String loginUserToMap(LoginUser data) => json.encode(data.toMap());

class LoginUser {
  bool status;
  String message;
  String token;
  User user;

  LoginUser({
   required this.status,
   required this.message,
   required this.token,
   required this.user,
  });

  factory LoginUser.fromMap(Map<String, dynamic> json) => LoginUser(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    user: User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "token": token,
    "user": user.toMap(),
  };
}

class User {
  int id;
  String name;
  String phoneNumber;
  String userType;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  Address address;

  User({
   required this.id,
   required this.name,
   required this.phoneNumber,
   required this.userType,
   required this.email,
   required this.emailVerifiedAt,
   required this.createdAt,
   required this.updatedAt,
   required this.address,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    userType: json["user_type"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    address: Address.fromMap(json["address"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "user_type": userType,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "address": address.toMap(),
  };
}

class Address {
  int id;
 // String userId;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String zipCode;
  String createdAt;
  String updatedAt;

  Address({
    required this.id,
   //required this.userId,
   required this.addressLine1,
   required this.addressLine2,
   required this.city,
   required this.state,
   required this.country,
   required this.zipCode,
   required this.createdAt,
   required this.updatedAt,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"],
  //  userId: json["user_id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipCode: json["zip_code"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    //"user_id": userId,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
