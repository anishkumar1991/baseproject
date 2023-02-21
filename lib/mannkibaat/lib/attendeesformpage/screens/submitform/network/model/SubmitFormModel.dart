// To parse this JSON data, do
//
//     final submitFormModel = submitFormModelFromJson(jsonString);

import 'dart:convert';

SubmitFormModel submitFormModelFromJson(String str) => SubmitFormModel.fromJson(json.decode(str));

String submitFormModelToJson(SubmitFormModel data) => json.encode(data.toJson());

class SubmitFormModel {
  SubmitFormModel({
    required this.skId,
    required this.boothId,
    required this.skName,
    required this.boothName,
    required this.totalAttendees,
    required this.address,
    required this.description,
    required this.eventId,
    required this.eventDetailId,
    required this.latitude,
    required this.longitude,
  });

  int skId;
  int boothId;
  String skName;
  String boothName;
  int totalAttendees;
  String address;
  String description;
  int eventId;
  int eventDetailId;
  String latitude;
  String longitude;

  factory SubmitFormModel.fromJson(Map<String, dynamic> json) => SubmitFormModel(
    skId: json["sk_id"],
    boothId: json["booth_id"],
    skName: json["sk_name"],
    boothName: json["booth_name"],
    totalAttendees: json["total_attendees"],
    address: json["address"],
    description: json["description"],
    eventId: json["event_id"],
    eventDetailId: json["event_detail_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "sk_id": skId,
    "booth_id": boothId,
    "sk_name": skName,
    "booth_name": boothName,
    "total_attendees": totalAttendees,
    "address": address,
    "description": description,
    "event_id": eventId,
    "event_detail_id": eventDetailId,
    "latitude": latitude,
    "longitude": longitude,
  };
}
