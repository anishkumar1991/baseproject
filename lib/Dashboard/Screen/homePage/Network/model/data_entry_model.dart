class DataEntryModel {
  bool? success;
  Data? data;
  String? message;

  DataEntryModel({this.success, this.data, this.message});

  DataEntryModel.fromJson(Map<String, dynamic> json) {
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
  List<UserData>? data;
  int? total;

  Data({this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(UserData.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? hindiName;
  String? englishName;
  String? phone;
  int? subUnitId;
  int? designation;
  String? designationName;
  String? designationNameSearchPerson;
  String? photo;

  UserData({
    this.id,
    this.name,
    this.hindiName,
    this.englishName,
    this.phone,
    this.subUnitId,
    this.designation,
    this.designationName,
    this.designationNameSearchPerson,
    this.photo,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hindiName = json['hindi_name'];
    englishName = json['english_name'];
    phone = json['phone'];
    subUnitId = json['sub_unit_id'];
    designation = json['designation'];
    designationName = json['designation_name'];
    designationNameSearchPerson = json['designation_name_search_person'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hindi_name'] = hindiName;
    data['english_name'] = englishName;
    data['phone'] = phone;
    data['sub_unit_id'] = subUnitId;
    data['designation'] = designation;
    data['designation_name'] = designationName;
    data['designation_name_search_person'] = designationNameSearchPerson;
    data['photo'] = photo;

    return data;
  }
}
