class LoginModel {
  bool? success;
  String? message;
  String? identificationToken;

  LoginModel({this.success, this.message, this.identificationToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    identificationToken = json['identification_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['identification_token'] = identificationToken;
    return data;
  }
}
