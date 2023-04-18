// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.responseCode,
    required this.responseStatus,
    required this.responseData,
    required this.responseMsg,
  });

  int responseCode;
  int responseStatus;
  ResponseData responseData;
  String responseMsg;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    responseCode: json["response_code"],
    responseStatus: json["response_status"],
    responseData: ResponseData.fromJson(json["response_data"]),
    responseMsg: json["response_msg"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "response_status": responseStatus,
    "response_data": responseData.toJson(),
    "response_msg": responseMsg,
  };
}

class ResponseData {
  ResponseData({
    required this.mobile,
    required this.status,
  });

  String mobile;
  String status;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    mobile: json["mobile"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "status": status,
  };
}
