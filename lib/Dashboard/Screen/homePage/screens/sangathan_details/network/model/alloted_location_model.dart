import '../../../zila_data_page/network/model/independent_drodown_model.dart';

class AllotedLocationModel {
  Data? data;
  String? message;

  AllotedLocationModel({this.data, this.message});

  AllotedLocationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? locationType;
  List<Locations>? locations;

  Data({this.locationType, this.locations});

  Data.fromJson(Map<String, dynamic> json) {
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
