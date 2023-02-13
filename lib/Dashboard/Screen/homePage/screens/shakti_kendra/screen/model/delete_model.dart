class DeleteModel {
  bool? success;
  Data? data;
  String? message;

  DeleteModel({this.success, this.data,this.message});

  DeleteModel.fromJson(Map<String, dynamic> json) {
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
  bool? askConfirmation;
  String? message;

  Data({this.askConfirmation, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    askConfirmation = json['ask_confirmation'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ask_confirmation'] = askConfirmation;
    data['message'] = message;
    return data;
  }
}
