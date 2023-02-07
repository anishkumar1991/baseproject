// To parse this JSON data, do
//
//     final viewCountModel = viewCountModelFromJson(jsonString);

import 'dart:convert';

ViewCountModel viewCountModelFromJson(String str) => ViewCountModel.fromJson(json.decode(str));

String viewCountModelToJson(ViewCountModel data) => json.encode(data.toJson());

class ViewCountModel {
  ViewCountModel({
    required this.postId,
    required this.durationInSec,
  });

  int postId;
  int durationInSec;

  factory ViewCountModel.fromJson(Map<String, dynamic> json) => ViewCountModel(
    postId: json["post_id"],
    durationInSec: json["duration_in_sec"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "duration_in_sec": durationInSec,
  };
}
