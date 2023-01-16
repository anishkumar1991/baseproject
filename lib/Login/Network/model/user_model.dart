class UserDetails {
  bool? success;
  String? message;
  String? authToken;
  User? user;
  List<Helplines>? helplines;

  UserDetails(
      {this.success, this.message, this.authToken, this.user, this.helplines});

  UserDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    authToken = json['auth_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['helplines'] != null) {
      helplines = <Helplines>[];
      json['helplines'].forEach((v) {
        helplines!.add(Helplines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['auth_token'] = authToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (helplines != null) {
      data['helplines'] = helplines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? address;
  String? gender;
  String? locale;
  String? countryStateName;
  int? countryStateId;
  bool? isJammuUser;
  String? role;
  List<dynamic>? permissions;
  String? socialMediaAccessToken;
  String? onboarding;
  String? twitterConsumerKey;
  String? twitterConsumerSecretKey;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.photo,
      this.address,
      this.gender,
      this.locale,
      this.countryStateName,
      this.countryStateId,
      this.isJammuUser,
      this.role,
      this.permissions,
      this.socialMediaAccessToken,
      this.onboarding,
      this.twitterConsumerKey,
      this.twitterConsumerSecretKey});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    address = json['address'];
    gender = json['gender'];
    locale = json['locale'];
    countryStateName = json['country_state_name'];
    countryStateId = json['country_state_id'];
    isJammuUser = json['is_jammu_user'];
    role = json['role'];
    if (json['permissions'] != null) {
      permissions = [];
      json['permissions'].forEach((v) {
        permissions!.add(v);
      });
    }
    socialMediaAccessToken = json['social_media_access_token'];
    onboarding = json['onboarding'];
    twitterConsumerKey = json['twitter_consumer_key'];
    twitterConsumerSecretKey = json['twitter_consumer_secret_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photo'] = photo;
    data['address'] = address;
    data['gender'] = gender;
    data['locale'] = locale;
    data['country_state_name'] = countryStateName;
    data['country_state_id'] = countryStateId;
    data['is_jammu_user'] = isJammuUser;
    data['role'] = role;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['social_media_access_token'] = socialMediaAccessToken;
    data['onboarding'] = onboarding;
    data['twitter_consumer_key'] = twitterConsumerKey;
    data['twitter_consumer_secret_key'] = twitterConsumerSecretKey;
    return data;
  }
}

class Helplines {
  String? title;
  String? phoneNumber;

  Helplines({this.title, this.phoneNumber});

  Helplines.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
