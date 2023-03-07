// To parse this JSON data, do
//
//     final editableFormModel = editableFormModelFromJson(jsonString);

import 'dart:convert';

EditableFormModel editableFormModelFromJson(String str) => EditableFormModel.fromJson(json.decode(str));

String editableFormModelToJson(EditableFormModel data) => json.encode(data.toJson());

class EditableFormModel {
  EditableFormModel({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  bool status;
  String message;
  Data data;
  String code;

  factory EditableFormModel.fromJson(Map<String, dynamic> json) => EditableFormModel(
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
    required this.totalAttendees,
    required this.address,
    required this.description,
    required this.photo1,
    required this.photo2,
    required this.location,
    required this.ac,
    required this.skId,
    required this.skName,
    required this.countryStateRef,
    required this.countryState,
    required this.filledBy,
  });

  int id;
  String totalAttendees;
  String address;
  String description;
  String photo1;
  String photo2;
  List<Ac> location;
  List<Ac> ac;
  int skId;
  String skName;
  List<Ac> countryStateRef;
  List<Ac> countryState;
  int filledBy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    totalAttendees: json["total_attendees"],
    address: json["address"],
    description: json["description"],
    photo1: json["photo1"],
    photo2: json["photo2"],
    location: List<Ac>.from(json["location"].map((x) => Ac.fromJson(x))),
    ac: List<Ac>.from(json["ac"].map((x) => Ac.fromJson(x))),
    skId: json["sk_id"],
    skName: json["sk_name"],
    countryStateRef: List<Ac>.from(json["country_state_ref"].map((x) => Ac.fromJson(x))),
    countryState: List<Ac>.from(json["country_state"].map((x) => Ac.fromJson(x))),
    filledBy: json["filled_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_attendees": totalAttendees,
    "address": address,
    "description": description,
    "photo1": photo1,
    "photo2": photo2,
    "location": List<dynamic>.from(location.map((x) => x.toJson())),
    "ac": List<dynamic>.from(ac.map((x) => x.toJson())),
    "sk_id": skId,
    "sk_name": skName,
    "country_state_ref": List<dynamic>.from(countryStateRef.map((x) => x.toJson())),
    "country_state": List<dynamic>.from(countryState.map((x) => x.toJson())),
    "filled_by": filledBy,
  };
}

class Ac {
  Ac({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Ac.fromJson(Map<String, dynamic> json) => Ac(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
