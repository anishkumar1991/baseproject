import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'SendFcmToken.g.dart';

@RestApi(baseUrl: AppStrings.notificationbaseUrl)
abstract class SendFcmTokenApi {
  factory SendFcmTokenApi(Dio dio) = _SendFcmTokenApi;

  @POST("/notification/api/fcm_notification_phone")
  Future<HttpResponse> sendFcm(@Body() Map<String, dynamic> data);
}
