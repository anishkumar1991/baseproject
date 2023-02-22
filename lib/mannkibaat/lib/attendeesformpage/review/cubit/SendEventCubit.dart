import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      String? longitute) async {
    try {
      String? _auth =
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.1aBzmXruUAVV7ancpI1gu6GhOSso9xUqONf2DZ9ICmA";
      print(_auth);
      final res = await api.sendEvent(_auth, {
        "booth_id": boothId,
        "booth_name": boothname,
        "total_attendees": totalatendees,
        "address": address,
        "description": description,
        "event_id": eventId,
        "latitude": latitude,
        "longitude": longitute
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
