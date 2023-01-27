class CastModel {
  bool? success;
  List<CastData>? data;
  String? message;

  CastModel({this.success, this.data, this.message});

  CastModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CastData>[];
      json['data'].forEach((v) {
        data!.add(CastData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class CastData {
  int? id;
  String? name;
  int? personCategoryId;

  CastData({this.id, this.name, this.personCategoryId});

  CastData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    personCategoryId = json['person_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['person_category_id'] = personCategoryId;
    return data;
  }
}
