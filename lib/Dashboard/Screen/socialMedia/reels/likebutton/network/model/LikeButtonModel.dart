// To parse this JSON data, do
//
//     final likeButtonModel = likeButtonModelFromJson(jsonString);

import 'dart:convert';

LikeButtonModel likeButtonModelFromJson(String str) =>
    LikeButtonModel.fromJson(json.decode(str));

String likeButtonModelToJson(LikeButtonModel data) =>
    json.encode(data.toJson());

class LikeButtonModel {
  LikeButtonModel({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory LikeButtonModel.fromJson(Map<String, dynamic> json) =>
      LikeButtonModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
