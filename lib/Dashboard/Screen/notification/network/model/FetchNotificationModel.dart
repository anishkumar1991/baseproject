// To parse this JSON data, do
//
//     final fetchNotificationModel = fetchNotificationModelFromJson(jsonString);

import 'dart:convert';

FetchNotificationModel fetchNotificationModelFromJson(String str) =>
    FetchNotificationModel.fromJson(json.decode(str));

String fetchNotificationModelToJson(FetchNotificationModel data) =>
    json.encode(data.toJson());

class FetchNotificationModel {
  FetchNotificationModel({
    required this.statusCode,
    required this.notificationsList,
  });

  String statusCode;
  List<NotificationsList> notificationsList;

  factory FetchNotificationModel.fromJson(Map<String, dynamic> json) =>
      FetchNotificationModel(
        statusCode: json["statusCode"],
        notificationsList: List<NotificationsList>.from(
            json["notifications_list"]
                .map((x) => NotificationsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "notifications_list":
            List<dynamic>.from(notificationsList.map((x) => x.toJson())),
      };
}

class NotificationsList {
  NotificationsList({
    required this.notificationTitle,
    required this.description,
    required this.uploadFile,
    required this.currentTime,
  });

  String notificationTitle;
  String description;
  String uploadFile;
  DateTime currentTime;

  factory NotificationsList.fromJson(Map<String, dynamic> json) =>
      NotificationsList(
        notificationTitle: json["notification_title"],
        description: json["description"],
        uploadFile: json["upload_file"],
        currentTime: DateTime.parse(json["current_time"]),
      );

  Map<String, dynamic> toJson() => {
        "notification_title": notificationTitle,
        "description": description,
        "upload_file": uploadFile,
        "current_time":
            "${currentTime.year.toString().padLeft(4, '0')}-${currentTime.month.toString().padLeft(2, '0')}-${currentTime.day.toString().padLeft(2, '0')}",
      };
}
