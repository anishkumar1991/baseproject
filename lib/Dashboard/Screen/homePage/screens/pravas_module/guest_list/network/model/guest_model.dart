class GuestList {
  String? statusCode;
  List<Data>? data;
  String? nameTitle;
  bool? isNameShow;
  String? phoneTitle;
  bool? isPhoneShow;
  String? designationTitle;
  bool? isDesignationShow;

  GuestList(
      {this.statusCode,
        this.data,
        this.nameTitle,
        this.isNameShow,
        this.phoneTitle,
        this.isPhoneShow,
        this.designationTitle,
        this.isDesignationShow});

  GuestList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    nameTitle = json['name_title'];
    isNameShow = json['is_name_show'];
    phoneTitle = json['phone_title'];
    isPhoneShow = json['is_phone_show'];
    designationTitle = json['designation_title'];
    isDesignationShow = json['is_designation_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['name_title'] = nameTitle;
    data['is_name_show'] = isNameShow;
    data['phone_title'] = phoneTitle;
    data['is_phone_show'] = isPhoneShow;
    data['designation_title'] = designationTitle;
    data['is_designation_show'] = isDesignationShow;
    return data;
  }
}

class Data {
  int? iId;
  String? changeTs;
  String? createTs;
  bool? hidden;
  int? karyakramId;
  String? designation;
  String? name;
  int? phone;

  Data(
      {this.iId,
        this.changeTs,
        this.createTs,
        this.hidden,
        this.karyakramId,
        this.designation,
        this.name,
        this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    changeTs = json['change_ts'];
    createTs = json['create_ts'];
    hidden = json['hidden'];
    karyakramId = json['karyakram_id'];
    designation = json['designation'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = iId;
    data['change_ts'] = changeTs;
    data['create_ts'] = createTs;
    data['hidden'] = hidden;
    data['karyakram_id'] = karyakramId;
    data['designation'] = designation;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}