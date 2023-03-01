// To parse this JSON data, do
//
//     final userNewAddModel = userNewAddModelFromJson(jsonString);

import 'dart:convert';

UserNewAddModel userNewAddModelFromJson(String str) => UserNewAddModel.fromJson(json.decode(str));

String userNewAddModelToJson(UserNewAddModel data) => json.encode(data.toJson());

class UserNewAddModel {
  UserNewAddModel({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  bool status;
  String message;
  Data data;
  String code;

  factory UserNewAddModel.fromJson(Map<String, dynamic> json) => UserNewAddModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
    "code": code,
  };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.phone,
    this.voterId,
    this.education,
    this.profession,
    this.pinCode,
    this.whatsappNo,
    this.address,
    required this.photo,
    required this.countryState,
    required this.ac,
    required this.booth,
    required this.partyZila,
    required this.partyMandal,
    this.lat,
    this.long,
  });

  int id;
  String name;
  String phone;
  dynamic voterId;
  dynamic education;
  dynamic profession;
  dynamic pinCode;
  dynamic whatsappNo;
  dynamic address;
  String photo;
  List<CountryState> countryState;
  List<Ac> ac;
  List<dynamic> booth;
  List<dynamic> partyZila;
  List<dynamic> partyMandal;
  dynamic lat;
  dynamic long;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    voterId: json["voter_id"],
    education: json["education"],
    profession: json["profession"],
    pinCode: json["pin_code"],
    whatsappNo: json["whatsapp_no"],
    address: json["address"],
    photo: json["photo"],
    countryState: List<CountryState>.from(json["country_state"].map((x) => CountryState.fromJson(x))),
    ac: List<Ac>.from(json["ac"].map((x) => Ac.fromJson(x))),
    booth: List<dynamic>.from(json["booth"].map((x) => x)),
    partyZila: List<dynamic>.from(json["party_zila"].map((x) => x)),
    partyMandal: List<dynamic>.from(json["party_mandal"].map((x) => x)),
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "voter_id": voterId,
    "education": education,
    "profession": profession,
    "pin_code": pinCode,
    "whatsapp_no": whatsappNo,
    "address": address,
    "photo": photo,
    "country_state": List<dynamic>.from(countryState.map((x) => x.toJson())),
    "ac": List<dynamic>.from(ac.map((x) => x.toJson())),
    "booth": List<dynamic>.from(booth.map((x) => x)),
    "party_zila": List<dynamic>.from(partyZila.map((x) => x)),
    "party_mandal": List<dynamic>.from(partyMandal.map((x) => x)),
    "lat": lat,
    "long": long,
  };
}

class Ac {
  Ac({
    required this.name,
    required this.id,
    required this.number,
  });

  String? name;
  int? id;
  String? number;

  factory Ac.fromJson(Map<String, dynamic> json) => Ac(
    name: json["name"],
    id: json["id"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "number": number,
  };
}

class CountryState {
  CountryState({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory CountryState.fromJson(Map<String, dynamic> json) => CountryState(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
