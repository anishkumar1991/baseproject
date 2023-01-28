class DataUnitModel {
  bool? success;
  String? message;
  List<UnitData>? data;
  List<UnitData>? another;
  int? status;

  DataUnitModel(
      {this.success, this.message, this.data, this.another, this.status});

  DataUnitModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UnitData>[];
      json['data'].forEach((v) {
        data!.add(UnitData.fromJson(v));
      });
    }
    if (json['another'] != null) {
      another = <UnitData>[];
      json['another'].forEach((v) {
        another!.add(UnitData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (another != null) {
      data['another'] = another!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class UnitData {
  int? id;
  String? name;
  String? iconUrl;
  List<SubUnits>? subUnits;

  UnitData({this.id, this.name, this.iconUrl, this.subUnits});

  UnitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['icon_url'];
    if (json['sub_units'] != null) {
      subUnits = <SubUnits>[];
      json['sub_units'].forEach((v) {
        subUnits!.add(SubUnits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon_url'] = iconUrl;
    if (subUnits != null) {
      data['sub_units'] = subUnits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubUnits {
  int? id;
  String? name;
  String? iconUrl;
  int? displayOrder;

  SubUnits({this.id, this.name, this.iconUrl, this.displayOrder});

  SubUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['icon_url'];
    displayOrder = json['display_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon_url'] = iconUrl;
    data['display_order'] = displayOrder;
    return data;
  }
}
