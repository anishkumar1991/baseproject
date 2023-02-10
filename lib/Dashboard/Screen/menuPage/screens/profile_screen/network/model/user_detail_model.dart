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
  List<String>? phoneNumbers;
  String? dob;
  List<Addresses>? addresses;
  String? gender;
  Category? category;
  Category? caste;
  List<EducationalDetails>? educationalDetails;
  List<ProfessionalDetails>? professionalDetails;
  String? username;
  String? email;
  String? voterId;
  String? phoneNumber;
  String? avatar;
  List<Designation>? designation;
  int? percentage;
  Category? religion;

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
    phoneNumbers = json['phone_numbers'].cast<String>();
    dob = json['dob'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    gender = json['gender'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    caste = json['caste'] != null ? Category.fromJson(json['caste']) : null;
    if (json['educational_details'] != null) {
      educationalDetails = <EducationalDetails>[];
      json['educational_details'].forEach((v) {
        educationalDetails!.add(EducationalDetails.fromJson(v));
      });
    }
    if (json['professional_details'] != null) {
      professionalDetails = <ProfessionalDetails>[];
      json['professional_details'].forEach((v) {
        professionalDetails!.add(ProfessionalDetails.fromJson(v));
      });
    }
    username = json['username'];
    email = json['email'];
    voterId = json['voter_id'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    if (json['designation'] != null) {
      designation = <Designation>[];
      json['designation'].forEach((v) {
        designation!.add(Designation.fromJson(v));
      });
    }
    percentage = json['percentage'];
    religion =
        json['religion'] != null ? Category.fromJson(json['religion']) : null;
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
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (caste != null) {
      data['caste'] = caste!.toJson();
    }
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
    if (religion != null) {
      data['religion'] = religion!.toJson();
    }
    return data;
  }
}

class Addresses {
  String? area;
  String? city;
  String? uuid;
  String? state;
  String? pinCode;
  String? houseNumber;
  String? forAddress;

  Addresses(
      {this.area,
      this.city,
      this.uuid,
      this.state,
      this.pinCode,
      this.forAddress,
      this.houseNumber});

  Addresses.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    city = json['city'];
    uuid = json['uuid'];
    state = json['state'];
    pinCode = json['pin_code'];
    houseNumber = json['house_number'];
    forAddress = json['for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['city'] = city;
    data['uuid'] = uuid;
    data['state'] = state;
    data['pin_code'] = pinCode;
    data['house_number'] = houseNumber;
    data['for'] = forAddress;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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

  EducationalDetails(
      {this.uuid, this.level, this.endYear, this.institute, this.startYear});

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

  ProfessionalDetails(
      {this.uuid, this.endYear, this.orgName, this.position, this.startYear});

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

class Designation {
  String? state;
  String? type;
  String? dataLevel;
  String? levelName;
  String? unit;
  String? subUnit;
  String? designation;
  String? location;

  Designation(
      {this.state,
      this.type,
      this.dataLevel,
      this.levelName,
      this.unit,
      this.subUnit,
      this.designation,
      this.location});

  Designation.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    type = json['type'];
    dataLevel = json['data_level'];
    levelName = json['level_name'];
    unit = json['unit'];
    subUnit = json['sub_unit'];
    designation = json['designation'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['type'] = type;
    data['data_level'] = dataLevel;
    data['level_name'] = levelName;
    data['unit'] = unit;
    data['sub_unit'] = subUnit;
    data['designation'] = designation;
    data['location'] = location;
    return data;
  }
}
