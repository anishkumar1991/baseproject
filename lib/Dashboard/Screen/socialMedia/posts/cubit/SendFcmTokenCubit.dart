import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Storage/user_storage_service.dart';
import '../network/services/fetchposts/FetchPostsApi.dart';
import '../network/services/sendfcmtoken/SendFcmToken.dart';
import 'ReactionState.dart';
import 'SendFcmTokenState.dart';

class SendFcmTokenCubit extends Cubit<SendFcmTokenState> {
  SendFcmTokenCubit() : super(SendFcmTokenInitialState());

  final api = SendFcmTokenApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> sendFcm(var fcm, String phone) async {
    try {
      final res = await api.sendFcm(
          {"fcm_token": fcm.toString(), "phone": phone, "device_id": " "});
      if (res.response.statusCode == 200) {
        print("FCM token sended");
        emit(SendFcmTokenSendedState());
      } else {
        print("fcm not sended");
      }
    } on Exception catch (e) {
      print("fcm error");
    }
  }
}
