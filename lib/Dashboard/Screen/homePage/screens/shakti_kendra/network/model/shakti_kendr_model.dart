class ShaktiKendr {
  bool? success;
  List<Data>? data;
  String? message;

  ShaktiKendr({this.success, this.data, this.message});

  ShaktiKendr.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? assemblyConstituencyId;
  int? mandalId;
  String? number;
  Null? documentId;
  Null? deletedAt;
  Null? mahaSystemId;
  int? createdById;
  int? skPeople;
  List<Booths>? booths;
  Mandal? mandal;
  Mandal? createdBy;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
        booths!.add(new Booths.fromJson(v));
      });
    }
    mandal =
    json['mandal'] != null ? new Mandal.fromJson(json['mandal']) : null;
    createdBy = json['created_by'] != null
        ? new Mandal.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['assembly_constituency_id'] = this.assemblyConstituencyId;
    data['mandal_id'] = this.mandalId;
    data['number'] = this.number;
    data['document_id'] = this.documentId;
    data['deleted_at'] = this.deletedAt;
    data['maha_system_id'] = this.mahaSystemId;
    data['created_by_id'] = this.createdById;
    data['sk_people'] = this.skPeople;
    if (this.booths != null) {
      data['booths'] = this.booths!.map((v) => v.toJson()).toList();
    }
    if (this.mandal != null) {
      data['mandal'] = this.mandal!.toJson();
    }
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['country_state_id'] = this.countryStateId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}