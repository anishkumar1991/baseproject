import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/mannkibaat.dart';

import '../network/SendEventDetails.dart';
import 'SendEventState.dart';

class SendEventCubit extends Cubit<SendEventState> {
  final api = SendEventDetailsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  SendEventCubit() : super(InitialState());

  Future sendEvent(
      int? boothId,
      String? boothname,
      int? totalatendees,
      String? address,
      String? description,
      int? eventId,
      String? latitude,
      String? longitute,
      String? photo1,
      String? photo2) async {
    try {
      String? auth = MKBStorageService.getUserAuthToken().toString();
      print(auth);
      final res = await api.sendEvent(auth, {
        "booth_id": boothId,
        "booth_name": boothname,
        "total_attendees": totalatendees,
        "address": address,
        "description": description,
        "event_id": eventId,
        "latitude": latitude,
        "longitude": longitute,
        "file_one": photo1 ?? " ",
        "file_two": photo2 ?? " "
      });
      if (res.response.statusCode == 200) {
        print("event details posted");
      } else {
        print("event details not posted");
      }
    } on Exception catch (e) {
      print("event details not posted");
    }
  }
}
