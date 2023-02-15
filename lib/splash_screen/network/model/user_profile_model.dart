class UserProfileModel {
  bool? success;
  Data? data;
  String? message;

  UserProfileModel({this.success, this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  dynamic phoneNumbers;
  String? dob;
  List<dynamic>? addresses;
  String? gender;
  dynamic category;
  dynamic caste;
  List<dynamic>? educationalDetails;
  List<dynamic>? professionalDetails;
  String? username;
  String? email;
  String? voterId;
  String? phoneNumber;
  String? avatar;
  List<dynamic>? designation;
  int? percentage;
  dynamic religion;

  Data(
      {this.id,
      this.name,
      this.phoneNumbers,
      this.dob,
      this.addresses,
      this.gender,
      this.category,
      this.caste,
      this.educationalDetails,
      this.professionalDetails,
      this.username,
      this.email,
      this.voterId,
      this.phoneNumber,
      this.avatar,
      this.designation,
      this.percentage,
      this.religion});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    try{
      if (json['phone_numbers'] != dynamic) {
        phoneNumbers = <dynamic>[];
        json['phone_numbers'].forEach((v) {
          phoneNumbers!.add(v);
        });
      }
    }catch(e){
      phoneNumbers = json['phone_numbers'];
    }
    dob = json['dob'];
    if (json['addresses'] != dynamic) {
      addresses = <dynamic>[];
      json['addresses'].forEach((v) {
        addresses!.add(v);
      });
    }
    gender = json['gender'];
    category = json['category'];
    caste = json['caste'];
    if (json['educational_details'] != dynamic) {
      educationalDetails = <dynamic>[];
      json['educational_details'].forEach((v) {
        educationalDetails!.add(v);
      });
    }
    if (json['professional_details'] != dynamic) {
      professionalDetails = <dynamic>[];
      json['professional_details'].forEach((v) {
        professionalDetails!.add(v);
      });
    }
    username = json['username'];
    email = json['email'];
    voterId = json['voter_id'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    if (json['designation'] != dynamic) {
      designation = <dynamic>[];
      json['designation'].forEach((v) {
        designation!.add(v);
      });
    }
    percentage = json['percentage'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (phoneNumbers != null) {
      data['phone_numbers'] = phoneNumbers!.map((v) => v.toJson()).toList();
    }
    data['dob'] = dob;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['gender'] = gender;
    data['category'] = category;
    data['caste'] = caste;
    if (educationalDetails != null) {
      data['educational_details'] =
          educationalDetails!.map((v) => v.toJson()).toList();
    }
    if (professionalDetails != null) {
      data['professional_details'] =
          professionalDetails!.map((v) => v.toJson()).toList();
    }
    data['username'] = username;
    data['email'] = email;
    data['voter_id'] = voterId;
    data['phone_number'] = phoneNumber;
    data['avatar'] = avatar;
    if (designation != null) {
      data['designation'] = designation!.map((v) => v.toJson()).toList();
    }
    data['percentage'] = percentage;
    data['religion'] = religion;
    return data;
  }
}
