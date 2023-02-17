class UserDetailModel {
  bool? success;
  Data? data;
  String? message;

  UserDetailModel({this.success, this.data, this.message});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<Addresses>? addresses;
  String? gender;
  dynamic? category;
  Caste? caste;
  List<EducationalDetails>? educationalDetails;
  List<ProfessionalDetails>? professionalDetails;
  String? username;
  String? email;
  String? voterId;
  String? phoneNumber;
  String? avatar;
  List<dynamic>? designation;
  int? percentage;
  dynamic religion;

  Data({this.id, this.name, this.phoneNumbers, this.dob, this.addresses, this.gender, this.category, this.caste, this.educationalDetails, this.professionalDetails, this.username, this.email, this.voterId, this.phoneNumber, this.avatar, this.designation, this.percentage, this.religion});

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
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) { addresses!.add(Addresses.fromJson(v)); });
    }
    gender = json['gender'];
    category = json['category'];
    caste = json['caste'] != null ? Caste.fromJson(json['caste']) : null;
    if (json['educational_details'] != null) {
      educationalDetails = <EducationalDetails>[];
      json['educational_details'].forEach((v) { educationalDetails!.add(EducationalDetails.fromJson(v)); });
    }
    if (json['professional_details'] != null) {
      professionalDetails = <ProfessionalDetails>[];
      json['professional_details'].forEach((v) { professionalDetails!.add(ProfessionalDetails.fromJson(v)); });
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
    data['phone_numbers'] = phoneNumbers;
    data['dob'] = dob;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['gender'] = gender;
    data['category'] = category;
    if (caste != null) {
      data['caste'] = caste!.toJson();
    }
    if (educationalDetails != null) {
      data['educational_details'] = educationalDetails!.map((v) => v.toJson()).toList();
    }
    if (professionalDetails != null) {
      data['professional_details'] = professionalDetails!.map((v) => v.toJson()).toList();
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

class Addresses {
  String? forWhich;
  String? area;
  String? city;
  dynamic uuid;
  String? state;
  String? pinCode;
  String? houseNumber;

  Addresses({this.forWhich, this.area, this.city, this.uuid, this.state, this.pinCode, this.houseNumber});

  Addresses.fromJson(Map<String, dynamic> json) {
    forWhich = json['for'];
    area = json['area'];
    city = json['city'];
    uuid = json['uuid'];
    state = json['state'];
    pinCode = json['pin_code'];
    houseNumber = json['house_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['for'] = forWhich;
    data['area'] = area;
    data['city'] = city;
    data['uuid'] = uuid;
    data['state'] = state;
    data['pin_code'] = pinCode;
    data['house_number'] = houseNumber;
    return data;
  }
}

class Caste {
  int? id;
  String? name;

  Caste({this.id, this.name});

  Caste.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class EducationalDetails {
  String? uuid;
  String? level;
  String? endYear;
  String? institute;
  String? startYear;

  EducationalDetails({this.uuid, this.level, this.endYear, this.institute, this.startYear});

  EducationalDetails.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    level = json['level'];
    endYear = json['end_year'];
    institute = json['institute'];
    startYear = json['start_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['level'] = level;
    data['end_year'] = endYear;
    data['institute'] = institute;
    data['start_year'] = startYear;
    return data;
  }
}

class ProfessionalDetails {
  String? uuid;
  String? endYear;
  String? orgName;
  String? position;
  String? startYear;

  ProfessionalDetails({this.uuid, this.endYear, this.orgName, this.position, this.startYear});

  ProfessionalDetails.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    endYear = json['end_year'];
    orgName = json['org_name'];
    position = json['position'];
    startYear = json['start_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['end_year'] = endYear;
    data['org_name'] = orgName;
    data['position'] = position;
    data['start_year'] = startYear;
    return data;
  }
}