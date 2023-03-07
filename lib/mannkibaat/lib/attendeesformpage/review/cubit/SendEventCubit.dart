import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/mannkibaat/lib/Storage/AttendeesFormStorage.dart';

import '../network/SendEventDetails.dart';
import '../network/model/SendEventDetails.dart';
import 'SendEventState.dart';

class SendEventCubit extends Cubit<SendEventState> {
  final api = SendEventDetailsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  SendEventCubit() : super(InitialState());

  Future sendEvent(
      String userAuthToken,
      int? boothId,
      String? boothname,
      int? totalatendees,
      String? address1,
      String? description1,
      int eventId,
      String? latitude1,
      String? longitute1,
      String photo1,
      String photo2) async {
    emit(EventSendingState());
    try {
      print("Bearer $userAuthToken");
      print("photo2 $photo2");

      final res = await api.sendEvent('Bearer $userAuthToken', {
        "booth_id": boothId,
        "booth_name": boothname,
        "total_attendees": totalatendees,
        "address": address1,
        "description": description1,
        "event_id": eventId,
        "latitude": latitude1,
        "longitude": longitute1,
        "file_one": photo1,
        "file_two": photo2,
      });

      if (res.response.statusCode == 200) {
        SendEventDetailsModel model = SendEventDetailsModel.fromJson(res.data);
        print(model.data);

        emit(EventSendState());
        print("event details posted");
        AttendeeStorageService.setimage1url("");
        AttendeeStorageService.setimage2url("");
      } else {
        print(res.response.statusCode);
        print(res.response.requestOptions.uri);
        print(res.response.requestOptions.headers);
        print(res.data);
        print("event details not posted");
        emit(EventErrorState(res.data["message"] ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      print("event details not posted exception");
      emit(EventErrorState(e.toString()));
    }
  }

  Future sendEventAgain(
      String userAuthToken,
      int? boothId,
      String? boothname,
      int? totalatendees,
      String? address1,
      String? description1,
      int eventId,
      String? latitude1,
      String? longitute1,
      String photo1,
      String photo2,
      String eventDetailId
      ) async {
    emit(EventSendingState());
    try {
      print("Bearer $userAuthToken");
      print("photo2 $photo2");

      final res = await api.sendEvent('Bearer $userAuthToken', {
        "booth_id": boothId,
        "booth_name": boothname,
        "total_attendees": totalatendees,
        "address": address1,
        "description": description1,
        "event_id": eventId,
        "event_detail_id": eventDetailId,
        "latitude": latitude1,
        "longitude": longitute1,
        "file_one": photo1,
        "file_two": photo2,
      });

      if (res.response.statusCode == 200) {
        SendEventDetailsModel model = SendEventDetailsModel.fromJson(res.data);
        print(model.data);

        emit(EventSendState());
        print("NEW event details posted");
        AttendeeStorageService.setimage1url("");
        AttendeeStorageService.setimage2url("");
      } else {
        print(res.response.statusCode);
        print(res.response.requestOptions.uri);
        print(res.response.requestOptions.headers);
        print(res.data);
        print("NEW event details not posted");
        emit(EventErrorState(res.data["message"] ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      print("NEW event details not posted exception");
      emit(EventErrorState(e.toString()));
    }
  }
}
