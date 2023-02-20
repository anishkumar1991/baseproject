// To parse this JSON data, do
//
//     final dashModal = dashModalFromJson(jsonString);

import 'dart:convert';

DashModal dashModalFromJson(String str) => DashModal.fromJson(json.decode(str));

String dashModalToJson(DashModal data) => json.encode(data.toJson());

class DashModal {
  DashModal({
    required this.data,
    required this.message,
    required this.status,
    required this.type,
  });

  List<Datum> data;
  List<String> message;
  int status;
  String type;

  factory DashModal.fromJson(Map<String, dynamic> json) => DashModal(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: List<String>.from(json["message"].map((x) => x)),
    status: json["status"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": List<dynamic>.from(message.map((x) => x)),
    "status": status,
    "type": type,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    this.status,
    required this.airedDetail,
    required this.canCreate,
    required this.eventDetail,
    required this.canEdit,
    required this.eventPhoto,
    required this.eventHasDetail,
  });

  int id;
  String name;
  String? status;
  AiredDetail airedDetail;
  bool canCreate;
  EventDetail eventDetail;
  bool canEdit;
  String eventPhoto;
  bool eventHasDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    airedDetail: AiredDetail.fromJson(json["aired_detail"]),
    canCreate: json["can_create"],
    eventDetail: EventDetail.fromJson(json["event_detail"]),
    canEdit: json["can_edit"],
    eventPhoto: json["event_photo"],
    eventHasDetail: json["event_has_detail?"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "aired_detail": airedDetail.toJson(),
    "can_create": canCreate,
    "event_detail": eventDetail.toJson(),
    "can_edit": canEdit,
    "event_photo": eventPhoto,
    "event_has_detail?": eventHasDetail,
  };
}

class AiredDetail {
  AiredDetail({
    required this.date,
    required this.time,
    required this.endDate,
  });

  String date;
  String time;
  String endDate;

  factory AiredDetail.fromJson(Map<String, dynamic> json) => AiredDetail(
    date: json["date"],
    time: json["time"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "time": time,
    "end_date": endDate,
  };
}

class EventDetail {
  EventDetail({
    this.id,
    this.totalAttendees,
    this.address,
    this.description,
    this.photo1,
    this.photo2,
    this.location,
    this.ac,
    this.skId,
    this.skName,
    this.countryStateRef,
    this.countryState,
    this.filledBy,
  });

  int? id;
  String? totalAttendees;
  String? address;
  String? description;
  String? photo1;
  String? photo2;
  List<Ac>? location;
  List<Ac>? ac;
  int? skId;
  String? skName;
  List<Ac>? countryStateRef;
  List<Ac>? countryState;
  int? filledBy;

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
    id: json["id"],
    totalAttendees: json["total_attendees"],
    address: json["address"],
    description: json["description"],
    photo1: json["photo1"],
    photo2: json["photo2"],
    location: json["location"] == null ? [] : List<Ac>.from(json["location"]!.map((x) => Ac.fromJson(x))),
    ac: json["ac"] == null ? [] : List<Ac>.from(json["ac"]!.map((x) => Ac.fromJson(x))),
    skId: json["sk_id"],
    skName: json["sk_name"],
    countryStateRef: json["country_state_ref"] == null ? [] : List<Ac>.from(json["country_state_ref"]!.map((x) => Ac.fromJson(x))),
    countryState: json["country_state"] == null ? [] : List<Ac>.from(json["country_state"]!.map((x) => Ac.fromJson(x))),
    filledBy: json["filled_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_attendees": totalAttendees,
    "address": address,
    "description": description,
    "photo1": photo1,
    "photo2": photo2,
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x.toJson())),
    "ac": ac == null ? [] : List<dynamic>.from(ac!.map((x) => x.toJson())),
    "sk_id": skId,
    "sk_name": skName,
    "country_state_ref": countryStateRef == null ? [] : List<dynamic>.from(countryStateRef!.map((x) => x.toJson())),
    "country_state": countryState == null ? [] : List<dynamic>.from(countryState!.map((x) => x.toJson())),
    "filled_by": filledBy,
  };
}

class Ac {
  Ac({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory Ac.fromJson(Map<String, dynamic> json) => Ac(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
