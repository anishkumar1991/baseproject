class FetchNotificationModel {
  String? statusCode;
  bool? isCircularShow;
  bool? isReportShow;
  List<NotificationsList>? notificationsList;

  FetchNotificationModel(
      {this.statusCode,
      this.isCircularShow,
      this.isReportShow,
      this.notificationsList});

  FetchNotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isCircularShow = json['is_circular_show'];
    isReportShow = json['is_report_show'];
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
    data['is_circular_show'] = this.isCircularShow;
    data['is_report_show'] = this.isReportShow;
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
  String? type;
  String? imgUrl;
  String? pdfUrl;
  String? linkUrl;
  String? sType;
  String? date;
  String? time;

  NotificationsList(
      {this.notificationTitle,
      this.description,
      this.share,
      this.type,
      this.imgUrl,
      this.pdfUrl,
      this.linkUrl,
      this.sType,
      this.date,
      this.time});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['notification_title'];
    description = json['description'];
    share = json['share'];
    type = json['type'];
    imgUrl = json['img_url'];
    pdfUrl = json['pdf_url'];
    linkUrl = json['link_url'];
    sType = json['_type'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_title'] = this.notificationTitle;
    data['description'] = this.description;
    data['share'] = this.share;
    data['type'] = this.type;
    data['img_url'] = this.imgUrl;
    data['pdf_url'] = this.pdfUrl;
    data['link_url'] = this.linkUrl;
    data['_type'] = this.sType;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
