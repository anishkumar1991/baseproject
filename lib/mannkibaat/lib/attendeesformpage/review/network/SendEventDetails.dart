import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Dashboard/Screen/whatsapp/screens/WhatsappScreen.dart';
import 'package:sangathan/Values/string.dart';

part 'SendEventDetails.g.dart';

@RestApi(baseUrl: AppStrings.baseUrlMannKiBaat)
abstract class SendEventDetailsApi {
  factory SendEventDetailsApi(Dio dio) = _SendEventDetailsApi;

  @POST('api/event_tracker/get_country_state')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> sendEvent(@Header('Authorization') String token, @Body() Map<String, dynamic> data);
}
