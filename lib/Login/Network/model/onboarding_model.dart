class OnboardingModel {
  bool? success;
  Data? data;
  String? message;

  OnboardingModel({this.success, this.data, this.message});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  bool? isJammuUser;
  String? onboarding;

  Data({this.isJammuUser, this.onboarding});

  Data.fromJson(Map<String, dynamic> json) {
    isJammuUser = json['is_jammu_user'];
    onboarding = json['onboarding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_jammu_user'] = isJammuUser;
    data['onboarding'] = onboarding;
    return data;
  }
}
