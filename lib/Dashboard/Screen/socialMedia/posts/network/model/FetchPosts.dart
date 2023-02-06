// To parse this JSON data, do
//
//     final fetchPosts = fetchPostsFromJson(jsonString);

import 'dart:convert';

FetchPosts fetchPostsFromJson(String str) => FetchPosts.fromJson(json.decode(str));

String fetchPostsToJson(FetchPosts data) => json.encode(data.toJson());

class FetchPosts {
  FetchPosts({
    required this.success,
    required this.posts,
    required this.message,
  });

  bool success;
  List<Post> posts;
  String message;

  factory FetchPosts.fromJson(Map<String, dynamic> json) => FetchPosts(
    success: json["success"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "message": message,
  };
}

class Post {
  Post({
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
  List<ReactionElement> reactions;
  Shares shares;
  MyReaction? myReaction;
  String dynamicLink;
  int viewCount;
  String sharingContent;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    caption: json["caption"],
    postType: json["post_type"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    postData: PostData.fromJson(json["post_data"]),
    reactions: List<ReactionElement>.from(json["reactions"].map((x) => ReactionElement.fromJson(x))),
    shares: Shares.fromJson(json["shares"]),
    myReaction: json["my_reaction"] == null ? null : MyReaction.fromJson(json["my_reaction"]),
    dynamicLink: json["dynamic_link"],
    viewCount: json["view_count"],
    sharingContent: json["sharing_content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "caption": caption,
    "post_type": postType,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
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
  ReactionEnum reaction;
  Unicode unicode;
  User user;

  factory MyReaction.fromJson(Map<String, dynamic> json) => MyReaction(
    id: json["id"],
    reaction: reactionEnumValues.map[json["reaction"]]!,
    unicode: unicodeValues.map[json["unicode"]]!,
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reaction": reactionEnumValues.reverse[reaction],
    "unicode": unicodeValues.reverse[unicode],
    "user": user.toJson(),
  };
}

enum ReactionEnum { ALL, LIKE, LOVE, WOW, SAD, ANGRY }

final reactionEnumValues = EnumValues({
  "all": ReactionEnum.ALL,
  "angry": ReactionEnum.ANGRY,
  "like": ReactionEnum.LIKE,
  "love": ReactionEnum.LOVE,
  "sad": ReactionEnum.SAD,
  "wow": ReactionEnum.WOW
});

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
    this.poll,
    this.link,
    this.reel,
    this.thumbnailUrl,
    this.thumbnailAspectRatio,
    this.aspectRatio,
    this.viewThresholdTime,
    this.video,
    this.images,
  });

  Poll? poll;
  Link? link;
  String? reel;
  String? thumbnailUrl;
  double? thumbnailAspectRatio;
  double? aspectRatio;
  int? viewThresholdTime;
  String? video;
  List<String>? images;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    poll: json["poll"] == null ? null : Poll.fromJson(json["poll"]),
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
    reel: json["reel"],
    thumbnailUrl: json["thumbnail_url"],
    thumbnailAspectRatio: json["thumbnail_aspect_ratio"]?.toDouble(),
    aspectRatio: json["aspect_ratio"],
    viewThresholdTime: json["view_threshold_time"],
    video: json["video"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "poll": poll?.toJson(),
    "link": link?.toJson(),
    "reel": reel,
    "thumbnail_url": thumbnailUrl,
    "thumbnail_aspect_ratio": thumbnailAspectRatio,
    "aspect_ratio": aspectRatio,
    "view_threshold_time": viewThresholdTime,
    "video": video,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class Link {
  Link({
    required this.id,
    required this.linkType,
    required this.url,
  });

  int id;
  String linkType;
  String url;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    id: json["id"],
    linkType: json["link_type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link_type": linkType,
    "url": url,
  };
}

class Poll {
  Poll({
    required this.id,
    required this.chartType,
    required this.totalVotes,
    required this.myOption,
    required this.options,
  });

  int id;
  String chartType;
  int? totalVotes;
  int? myOption;
  List<Option> options;

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    id: json["id"],
    chartType: json["chart_type"],
    totalVotes: json["total_votes"],
    myOption: json["my_option"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chart_type": chartType,
    "total_votes": totalVotes,
    "my_option": myOption,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    required this.id,
    required this.content,
    required this.votes,
    required this.color,
  });

  int id;
  String content;
  int votes;
  String color;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    content: json["content"],
    votes: json["votes"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "votes": votes,
    "color": color,
  };
}

class ReactionElement {
  ReactionElement({
    required this.reaction,
    required this.unicode,
    required this.count,
  });

  ReactionEnum reaction;
  Unicode unicode;
  int count;

  factory ReactionElement.fromJson(Map<String, dynamic> json) => ReactionElement(
    reaction: reactionEnumValues.map[json["reaction"]]!,
    unicode: unicodeValues.map[json["unicode"]]!,
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "reaction": reactionEnumValues.reverse[reaction],
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
