class DeleteModel {
  bool? success;
  Data? data;

  DeleteModel({this.success, this.data});

  DeleteModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? askConfirmation;
  String? message;

  Data({this.askConfirmation, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    askConfirmation = json['ask_confirmation'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask_confirmation'] = this.askConfirmation;
    data['message'] = this.message;
    return data;
  }
}
