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
        appPermissions!.add(AppPermissions.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (appPermissions != null) {
      data['app_permissions'] = appPermissions!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['permission_name'] = permissionName;
    data['action'] = action;
    return data;
  }
}
