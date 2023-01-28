class DesignationDataModel {
  bool? success;
  List<DesignationData>? data;
  int? status;

  DesignationDataModel({this.success, this.data, this.status});

  DesignationDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DesignationData>[];
      json['data'].forEach((v) {
        data!.add(DesignationData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class DesignationData {
  int? id;
  String? name;
  String? displayName;

  DesignationData({this.id, this.name, this.displayName});

  DesignationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    return data;
  }
}
