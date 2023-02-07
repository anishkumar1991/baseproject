// // To parse this JSON data, do
// //
// //     final shareModel = shareModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ShareModel shareModelFromJson(String str) => ShareModel.fromJson(json.decode(str));
//
// String shareModelToJson(ShareModel data) => json.encode(data.toJson());
//
// class ShareModel {
//   ShareModel({
//     required this.postId,
//     required this.isWhatsapp,
//   });
//
//   int postId;
//   bool isWhatsapp;
//
//   factory ShareModel.fromJson(Map<String, dynamic> json) => ShareModel(
//     postId: json["post_id"],
//     isWhatsapp: json["is_whatsapp"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "post_id": postId,
//     "is_whatsapp": isWhatsapp,
//   };
// }
