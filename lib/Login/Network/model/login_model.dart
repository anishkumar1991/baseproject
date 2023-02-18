// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.success,
    required this.message,
    required this.identificationToken,
  });

  bool success;
  String message;
  String identificationToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    identificationToken: json["identification_token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "identification_token": identificationToken,
  };
}
