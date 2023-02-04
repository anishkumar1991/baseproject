class ClientAppListsModel {
  bool? success;
  List<Sections>? sections;
  String? message;

  ClientAppListsModel({this.success, this.sections, this.message});

  ClientAppListsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Sections {
  String? title;
  String? type;
  List<Data>? data;

  Sections({this.title, this.type, this.data});

  Sections.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? image;
  String? actionUrl;
  String? clientId;
  String? appType;
  String? helpline;

  Data(
      {this.name,
      this.image,
      this.actionUrl,
      this.clientId,
      this.appType,
      this.helpline});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    actionUrl = json['action_url'];
    clientId = json['client_id'];
    appType = json['app_type'];
    helpline = json['helpline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['action_url'] = actionUrl;
    data['client_id'] = clientId;
    data['app_type'] = appType;
    data['helpline'] = helpline;
    return data;
  }
}
