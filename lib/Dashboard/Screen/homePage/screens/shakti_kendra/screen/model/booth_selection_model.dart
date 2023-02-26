class BoothListData {
  bool? success;
  List<Booth>? data;
  String? message;

  BoothListData({this.success, this.data, this.message});

  BoothListData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Booth>[];
      json['data'].forEach((v) {
        data!.add(Booth.fromJson(v));
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

class Booth {
  int? id;
  String? name;
  String? number;
  String? parentname;
  int? parentid;

  Booth({this.id, this.name, this.number, this.parentname, this.parentid});

  Booth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    parentname = json['parentname'];
    parentid = json['parentid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['parentname'] = parentname;
    data['parentid'] = parentid;
    return data;
  }
}
