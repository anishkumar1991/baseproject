class AddDataEntryModel {
  bool? success;
  List<ExistData>? data;
  String? message;
  String? message1;
  String? message2;
  bool? duplication;
  bool? showForceSubmit;

  AddDataEntryModel({this.success, this.data, this.message, this.duplication, this.showForceSubmit});

  AddDataEntryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ExistData>[];
      json['data'].forEach((v) {
        data!.add(ExistData.fromJson(v));
      });
    }
    message = json['message'];
    message1 = json['message1'];
    message2 = json['message2'];
    duplication = json['duplication'];
    showForceSubmit = json['showForceSubmit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['message1'] = message1;
    data['message2'] = message2;
    data['duplication'] = duplication;
    data['showForceSubmit'] = showForceSubmit;
    return data;
  }
}

class ExistData {
  int? id;
  String? name;
  String? location;
  dynamic designation;
  String? level;
  String? unit;
  String? subUnit;
  bool? deletable;

  ExistData({this.id, this.name, this.location, this.designation, this.level, this.unit, this.subUnit, this.deletable});

  ExistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    designation = json['designation'];
    level = json['level'];
    unit = json['unit'];
    subUnit = json['sub_unit'];
    deletable = json['deletable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['designation'] = designation;
    data['level'] = level;
    data['unit'] = unit;
    data['sub_unit'] = subUnit;
    data['deletable'] = deletable;
    return data;
  }
}
