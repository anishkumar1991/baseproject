class BoothPannasStatus {
  bool? success;
  Data? data;
  String? message;

  BoothPannasStatus({this.success, this.data, this.message});

  BoothPannasStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? total;
  int? pramukh;
  int? samiti;

  Data({this.total, this.pramukh, this.samiti});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pramukh = json['pramukh'];
    samiti = json['samiti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pramukh'] = pramukh;
    data['samiti'] = samiti;
    return data;
  }
}
