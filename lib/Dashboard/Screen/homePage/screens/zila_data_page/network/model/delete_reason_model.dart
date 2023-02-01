class DeleteReasonModel {
  bool? status;
  Data? data;
  String? message;

  DeleteReasonModel({this.status, this.data, this.message});

  DeleteReasonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  DeletionReasons? deletionReasons;

  Data({this.deletionReasons});

  Data.fromJson(Map<String, dynamic> json) {
    deletionReasons = json['deletion_reasons'] != null
        ? DeletionReasons.fromJson(json['deletion_reasons'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deletionReasons != null) {
      data['deletion_reasons'] = deletionReasons!.toJson();
    }
    return data;
  }
}

class DeletionReasons {
  List<String>? electedRepresentative;
  List<String>? karyakarta;

  DeletionReasons({this.electedRepresentative, this.karyakarta});

  DeletionReasons.fromJson(Map<String, dynamic> json) {
    electedRepresentative = json['elected_representative'].cast<String>();
    karyakarta = json['karyakarta'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elected_representative'] = electedRepresentative;
    data['karyakarta'] = karyakarta;
    return data;
  }
}
