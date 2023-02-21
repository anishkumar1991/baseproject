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
  String? share;
  String? imgUrl;
  String? pdfUrl;
  String? linkUrl;
  String? type;
  String? sType;
  String? date;
  String? time;

  NotificationsList(
      {this.notificationTitle,
        this.description,
        this.share,
        this.imgUrl,
        this.pdfUrl,
        this.linkUrl,
        this.type,
        this.sType,
        this.date,
        this.time});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['notification_title'];
    description = json['description'];
    share = json['share'];
    imgUrl = json['img_url'];
    pdfUrl = json['pdf_url'];
    linkUrl = json['link_url'];
    type = json['type'];
    sType = json['_type'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_title'] = this.notificationTitle;
    data['description'] = this.description;
    data['share'] = this.share;
    data['img_url'] = this.imgUrl;
    data['pdf_url'] = this.pdfUrl;
    data['link_url'] = this.linkUrl;
    data['type'] = this.type;
    data['_type'] = this.sType;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}