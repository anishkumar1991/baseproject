class SangthanDataModel {
  bool? success;
  List<SangathanData>? data;
  String? message;

  SangthanDataModel({this.success, this.data, this.message});

  SangthanDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SangathanData>[];
      json['data'].forEach((v) {
        data!.add(SangathanData.fromJson(v));
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

class SangathanData {
  int? id;
  String? name;
  String? levelClass;
  int? orderId;
  String? iconUrl;

  SangathanData({this.id, this.name, this.levelClass, this.orderId, this.iconUrl});

  SangathanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    levelClass = json['level_class'];
    orderId = json['order_id'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level_class'] = levelClass;
    data['order_id'] = orderId;
    data['icon_url'] = iconUrl;
    return data;
  }
}
