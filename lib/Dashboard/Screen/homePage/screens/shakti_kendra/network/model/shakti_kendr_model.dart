class ShaktiKendr {
  bool? success;
  List<ShaktiKendrData>? data;
  String? message;

  ShaktiKendr({this.success, this.data, this.message});

  ShaktiKendr.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ShaktiKendrData>[];
      json['data'].forEach((v) {
        data!.add(ShaktiKendrData.fromJson(v));
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

class ShaktiKendrData {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? assemblyConstituencyId;
  int? mandalId;
  String? number;
  dynamic documentId;
  dynamic deletedAt;
  dynamic mahaSystemId;
  int? createdById;
  int? skPeople;
  List<Booths>? booths;
  Mandal? mandal;
  Mandal? createdBy;

  ShaktiKendrData(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.assemblyConstituencyId,
      this.mandalId,
      this.number,
      this.documentId,
      this.deletedAt,
      this.mahaSystemId,
      this.createdById,
      this.skPeople,
      this.booths,
      this.mandal,
      this.createdBy});

  ShaktiKendrData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    assemblyConstituencyId = json['assembly_constituency_id'];
    mandalId = json['mandal_id'];
    number = json['number'];
    documentId = json['document_id'];
    deletedAt = json['deleted_at'];
    mahaSystemId = json['maha_system_id'];
    createdById = json['created_by_id'];
    skPeople = json['sk_people'];
    if (json['booths'] != null) {
      booths = <Booths>[];
      json['booths'].forEach((v) {
        booths!.add(Booths.fromJson(v));
      });
    }
    mandal = json['mandal'] != null ? Mandal.fromJson(json['mandal']) : null;
    createdBy = json['created_by'] != null ? Mandal.fromJson(json['created_by']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['assembly_constituency_id'] = assemblyConstituencyId;
    data['mandal_id'] = mandalId;
    data['number'] = number;
    data['document_id'] = documentId;
    data['deleted_at'] = deletedAt;
    data['maha_system_id'] = mahaSystemId;
    data['created_by_id'] = createdById;
    data['sk_people'] = skPeople;
    if (booths != null) {
      data['booths'] = booths!.map((v) => v.toJson()).toList();
    }
    if (mandal != null) {
      data['mandal'] = mandal!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }
}

class Booths {
  int? id;
  String? name;
  String? number;
  int? countryStateId;

  Booths({this.id, this.name, this.number, this.countryStateId});

  Booths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    countryStateId = json['country_state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['country_state_id'] = countryStateId;
    return data;
  }
}

class Mandal {
  int? id;
  String? name;

  Mandal({this.id, this.name});

  Mandal.fromJson(Map<String, dynamic> json) {
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
