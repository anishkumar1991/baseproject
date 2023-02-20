// To parse this JSON data, do
//
//     final booth = boothFromJson(jsonString);

import 'dart:convert';

Booth boothFromJson(String str) => Booth.fromJson(json.decode(str));

String boothToJson(Booth data) => json.encode(data.toJson());

class Booth {
  Booth({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  bool status;
  String message;
  List<Datum> data;
  String code;

  factory Booth.fromJson(Map<String, dynamic> json) => Booth(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.number,
    required this.name,
    required this.intNumber,
    required this.stringNumber,
  });

  int id;
  String number;
  String name;
  int intNumber;
  String stringNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    number: json["number"],
    name: json["name"],
    intNumber: json["int_number"],
    stringNumber: json["string_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "name": name,
    "int_number": intNumber,
    "string_number": stringNumber,
  };
}
