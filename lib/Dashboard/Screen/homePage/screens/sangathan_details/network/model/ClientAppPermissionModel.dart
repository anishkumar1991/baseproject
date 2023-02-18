class ClientAppPermissionModel {
  bool? success;
  List<AppPermissions>? appPermissions;
  String? message;

  ClientAppPermissionModel({this.success, this.appPermissions, this.message});

  ClientAppPermissionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['app_permissions'] != null) {
      appPermissions = <AppPermissions>[];
      json['app_permissions'].forEach((v) {
        appPermissions!.add(new AppPermissions.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.appPermissions != null) {
      data['app_permissions'] =
          this.appPermissions!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AppPermissions {
  int? id;
  String? permissionName;
  String? action;

  AppPermissions({this.id, this.permissionName, this.action});

  AppPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    permissionName = json['permission_name'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['permission_name'] = this.permissionName;
    data['action'] = this.action;
    return data;
  }
}