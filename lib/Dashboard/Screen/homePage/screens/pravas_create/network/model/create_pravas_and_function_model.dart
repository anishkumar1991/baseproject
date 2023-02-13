class CreatePravasAndFunctionModel {
  String? statusCode;
  String? message;
  Data? data;
  int? status;

  CreatePravasAndFunctionModel(
      {this.statusCode, this.message, this.data, this.status});

  CreatePravasAndFunctionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? pravasId;

  Data({this.pravasId});

  Data.fromJson(Map<String, dynamic> json) {
    pravasId = json['pravas_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pravas_id'] = this.pravasId;
    return data;
  }
}