class IndependentDropdownModel {
  IndependentData? data;
  String? message;

  IndependentDropdownModel({this.data, this.message});

  IndependentDropdownModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? IndependentData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class IndependentData {
  String? locationType;
  List<Locations>? locations;

  IndependentData({this.locationType, this.locations});

  IndependentData.fromJson(Map<String, dynamic> json) {
    locationType = json['location_type'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_type'] = locationType;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  String? number;
  int? mandalId;
  String? mandalName;

  Locations({this.id, this.name, this.number, this.mandalId, this.mandalName});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    mandalId = json['mandal_id'];
    mandalName = json['mandal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['mandal_id'] = mandalId;
    data['mandal_name'] = mandalName;
    return data;
  }
}
