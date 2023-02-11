class FetchNotificationModel {
  String? statusCode;
  List<NotificationsList>? notificationsList;

  FetchNotificationModel({this.statusCode, this.notificationsList});

  FetchNotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['notifications_list'] != null) {
      notificationsList = <NotificationsList>[];
      json['notifications_list'].forEach((v) {
        notificationsList!.add(new NotificationsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.notificationsList != null) {
      data['notifications_list'] =
          this.notificationsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsList {
  String? notificationTitle;
  String? description;
  String? sType;
  String? share;
  String? uploadFile;
  String? date;
  String? time;
  String? attachmentType;
  Null? link;
  String? fcm;

  NotificationsList(
      {this.notificationTitle,
        this.description,
        this.sType,
        this.share,
        this.uploadFile,
        this.date,
        this.time,
        this.attachmentType,
        this.link,
        this.fcm});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['notification_title'];
    description = json['description'];
    sType = json['_type'];
    share = json['share'];
    uploadFile = json['upload_file'];
    date = json['date'];
    time = json['time'];
    attachmentType = json['attachment_type'];
    link = json['link'];
    fcm = json['fcm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_title'] = this.notificationTitle;
    data['description'] = this.description;
    data['_type'] = this.sType;
    data['share'] = this.share;
    data['upload_file'] = this.uploadFile;
    data['date'] = this.date;
    data['time'] = this.time;
    data['attachment_type'] = this.attachmentType;
    data['link'] = this.link;
    data['fcm'] = this.fcm;
    return data;
  }
}