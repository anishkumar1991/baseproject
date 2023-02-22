import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/notification/network/services/FetchNotificationApi.dart';
import 'package:sangathan/Storage/user_storage_service.dart';

import '../../../../generated/l10n.dart';
import '../network/model/FetchNotificationModel.dart';
import 'NotificationState.dart';

class NotificationCubit extends Cubit<NotificationState> {
  String? twitterId;
  FetchNotificationModel? tempModel;
  String? tweeturl;
  String? tweettext;

  NotificationCubit() : super(InitialNotificationState());
  final api = FetchNotificationApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> fetchNotification() async {
    emit(NotificationFetchingState());

    try {
      final res =
          await api.getNotification('${StorageService.userAuthToken}');
      if (res.response.statusCode == 200) {
        print("fetching notification api working");
        FetchNotificationModel model =
            FetchNotificationModel.fromJson(res.data);
        tempModel = model;
        emit(NotificationFetchedState());
        tempModel = model;
      } else {
        emit(NotificationErrorState());
      }
    } on Exception catch (e) {
      emit(NotificationErrorState());
    }
  }
}
