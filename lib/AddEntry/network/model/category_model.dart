class DropdownValueModel {
  bool? status;
  Data? data;
  String? message;

  DropdownValueModel({this.status, this.data, this.message});

  DropdownValueModel.fromJson(Map<String, dynamic> json) {
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
  List<DropdownData>? religion;
  List<DropdownData>? personCategory;
  List<DropdownData>? personEducation;
  List<DropdownData>? personProfession;
  List<DropdownData>? nativeState;
  List<String>? salutations;
  List<int>? pannaDesignationIds;
  List<int>? memberDesignationIds;
  List<DropdownData>? inclinations;

  Data(
      {this.religion,
      this.personCategory,
      this.personEducation,
      this.personProfession,
      this.nativeState,
      this.salutations,
      this.pannaDesignationIds,
      this.memberDesignationIds,
      this.inclinations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['religion'] != null) {
      religion = <DropdownData>[];
      json['religion'].forEach((v) {
        religion!.add(DropdownData.fromJson(v));
      });
    }
    if (json['person_category'] != null) {
      personCategory = <DropdownData>[];
      json['person_category'].forEach((v) {
        personCategory!.add(DropdownData.fromJson(v));
      });
    }
    if (json['person_education'] != null) {
      personEducation = <DropdownData>[];
      json['person_education'].forEach((v) {
        personEducation!.add(DropdownData.fromJson(v));
      });
    }
    if (json['person_profession'] != null) {
      personProfession = <DropdownData>[];
      json['person_profession'].forEach((v) {
        personProfession!.add(DropdownData.fromJson(v));
      });
    }
    if (json['native_state'] != null) {
      nativeState = <DropdownData>[];
      json['native_state'].forEach((v) {
        nativeState!.add(DropdownData.fromJson(v));
      });
    }
    salutations = json['salutations'].cast<String>();
    pannaDesignationIds = json['panna_designation_ids'].cast<int>();
    memberDesignationIds = json['member_designation_ids'].cast<int>();
    if (json['inclinations'] != null) {
      inclinations = <DropdownData>[];
      json['inclinations'].forEach((v) {
        inclinations!.add(DropdownData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (religion != null) {
      data['religion'] = religion!.map((v) => v.toJson()).toList();
    }
    if (personCategory != null) {
      data['person_category'] =
          personCategory!.map((v) => v.toJson()).toList();
    }
    if (personEducation != null) {
      data['person_education'] =
          personEducation!.map((v) => v.toJson()).toList();
    }
    if (personProfession != null) {
      data['person_profession'] =
          personProfession!.map((v) => v.toJson()).toList();
    }
    if (nativeState != null) {
      data['native_state'] = nativeState!.map((v) => v.toJson()).toList();
    }
    data['salutations'] = salutations;
    data['panna_designation_ids'] = pannaDesignationIds;
    data['member_designation_ids'] = memberDesignationIds;
    if (inclinations != null) {
      data['inclinations'] = inclinations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DropdownData {
  int? id;
  String? name;

  DropdownData({this.id, this.name});

  DropdownData.fromJson(Map<String, dynamic> json) {
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
