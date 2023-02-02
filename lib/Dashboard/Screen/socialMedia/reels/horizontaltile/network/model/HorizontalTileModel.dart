// To parse this JSON data, do
//
//     final horizontalTileModel = horizontalTileModelFromJson(jsonString);

import 'dart:convert';

HorizontalTileModel horizontalTileModelFromJson(String str) =>
    HorizontalTileModel.fromJson(json.decode(str));

String horizontalTileModelToJson(HorizontalTileModel data) =>
    json.encode(data.toJson());

class HorizontalTileModel {
  HorizontalTileModel({
    required this.success,
    required this.reels,
    required this.message,
  });

  bool success;
  List<Reel> reels;
  String message;

  factory HorizontalTileModel.fromJson(Map<String, dynamic> json) =>
      HorizontalTileModel(
        success: json["success"],
        reels: List<Reel>.from(json["reels"].map((x) => Reel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "reels": List<dynamic>.from(reels.map((x) => x.toJson())),
        "message": message,
      };
}

class Reel {
  Reel({
    required this.id,
    required this.title,
    required this.caption,
    required this.postType,
    required this.startDate,
    required this.endDate,
    required this.tags,
    required this.postData,
    required this.reactions,
    required this.shares,
    this.myReaction,
    required this.dynamicLink,
    required this.viewCount,
    required this.sharingContent,
  });

  int id;
  String title;
  String caption;
  String postType;
  DateTime startDate;
  DateTime endDate;
  List<String> tags;
  PostData postData;
  List<Reaction> reactions;
  Shares shares;
  MyReaction? myReaction;
  String dynamicLink;
  int viewCount;
  String sharingContent;

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"],
        title: json["title"],
        caption: json["caption"],
        postType: json["post_type"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        postData: PostData.fromJson(json["post_data"]),
        reactions: List<Reaction>.from(
            json["reactions"].map((x) => Reaction.fromJson(x))),
        shares: Shares.fromJson(json["shares"]),
        myReaction: json["my_reaction"] == null
            ? null
            : MyReaction.fromJson(json["my_reaction"]),
        dynamicLink: json["dynamic_link"],
        viewCount: json["view_count"],
        sharingContent: json["sharing_content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "caption": caption,
        "post_type": postType,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "post_data": postData.toJson(),
        "reactions": List<dynamic>.from(reactions.map((x) => x.toJson())),
        "shares": shares.toJson(),
        "my_reaction": myReaction?.toJson(),
        "dynamic_link": dynamicLink,
        "view_count": viewCount,
        "sharing_content": sharingContent,
      };
}

class MyReaction {
  MyReaction({
    required this.id,
    required this.reaction,
    required this.unicode,
    required this.user,
  });

  int id;
  String reaction;
  Unicode unicode;
  User user;

  factory MyReaction.fromJson(Map<String, dynamic> json) => MyReaction(
        id: json["id"],
        reaction: json["reaction"],
        unicode: unicodeValues.map[json["unicode"]]!,
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reaction": reaction,
        "unicode": unicodeValues.reverse[unicode],
        "user": user.toJson(),
      };
}

enum Unicode { EMPTY, UNICODE, PURPLE, FLUFFY, TENTACLED }

final unicodeValues = EnumValues({
  "\ud83d\udc4d": Unicode.EMPTY,
  "\ud83d\ude14": Unicode.FLUFFY,
  "\ud83d\ude2e": Unicode.PURPLE,
  "\ud83d\ude21": Unicode.TENTACLED,
  "❤": Unicode.UNICODE
});

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  int id;
  String name;
  String email;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
      };
}

class PostData {
  PostData({
    required this.reel,
    required this.thumbnailUrl,
    required this.thumbnailAspectRatio,
    required this.aspectRatio,
    required this.viewThresholdTime,
  });

  String reel;
  String thumbnailUrl;
  double thumbnailAspectRatio;
  double aspectRatio;
  int viewThresholdTime;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        reel: json["reel"],
        thumbnailUrl: json["thumbnail_url"],
        thumbnailAspectRatio: json["thumbnail_aspect_ratio"]?.toDouble(),
        aspectRatio: json["aspect_ratio"]?.toDouble(),
        viewThresholdTime: json["view_threshold_time"],
      );

  Map<String, dynamic> toJson() => {
        "reel": reel,
        "thumbnail_url": thumbnailUrl,
        "thumbnail_aspect_ratio": thumbnailAspectRatio,
        "aspect_ratio": aspectRatio,
        "view_threshold_time": viewThresholdTime,
      };
}

class Reaction {
  Reaction({
    required this.reaction,
    required this.unicode,
    required this.count,
  });

  String reaction;
  Unicode unicode;
  int count;

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        reaction: json["reaction"],
        unicode: unicodeValues.map[json["unicode"]]!,
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "reaction": reaction,
        "unicode": unicodeValues.reverse[unicode],
        "count": count,
      };
}

class Shares {
  Shares({
    required this.whatsapp,
    required this.other,
  });

  int whatsapp;
  int other;

  factory Shares.fromJson(Map<String, dynamic> json) => Shares(
        whatsapp: json["whatsapp"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "whatsapp": whatsapp,
        "other": other,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
