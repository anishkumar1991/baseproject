import 'dart:convert';

class LoginModel {
  bool? status;
  String? message;
  Data? data;
  String? code;

  LoginModel({this.status, this.message, this.data, this.code});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? identificationToken;

  Data({this.identificationToken});

  Data.fromJson(Map<String, dynamic> json) {
    identificationToken = json['identification_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identification_token'] = this.identificationToken;
    return data;
  }
}
