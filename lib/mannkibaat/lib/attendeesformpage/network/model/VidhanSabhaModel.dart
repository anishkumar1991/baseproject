// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  bool status;
  String message;
  List<ApiDataList> data;
  String code;

  factory States.fromJson(Map<String, dynamic> json) => States(
    status: json["status"],
    message: json["message"],
    data: List<ApiDataList>.from(json["data"].map((x) => ApiDataList.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code,
  };
}

class ApiDataList {
  ApiDataList({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory ApiDataList.fromJson(Map<String, dynamic> json) => ApiDataList(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
