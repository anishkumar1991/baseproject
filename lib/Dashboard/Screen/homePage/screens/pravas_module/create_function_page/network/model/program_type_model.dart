import 'program_comman_dropdown_model.dart';

class ProgramTypeModel {
  String? message;
  List<ProgramDropdownModel>? data;

  ProgramTypeModel({this.message, this.data});

  ProgramTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ProgramDropdownModel>[];
      json['data'].forEach((v) {
        data!.add(ProgramDropdownModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
