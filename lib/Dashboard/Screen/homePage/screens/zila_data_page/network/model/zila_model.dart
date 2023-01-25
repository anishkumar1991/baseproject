class ZilaModel {
  List<PartyZilaData>? data;
  String? message;

  ZilaModel({this.data, this.message});

  ZilaModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PartyZilaData>[];
      json['data'].forEach((v) {
        data!.add(PartyZilaData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class PartyZilaData {
  int? id;
  String? name;

  PartyZilaData({this.id, this.name});

  PartyZilaData.fromJson(Map<String, dynamic> json) {
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
