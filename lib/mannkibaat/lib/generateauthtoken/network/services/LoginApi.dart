import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'LoginApi.g.dart';

@RestApi(baseUrl: AppStrings.baseUrlMannKiBaat)
abstract class MannKibaatAuthApi {
  factory MannKibaatAuthApi(Dio dio) = _MannKibaatAuthApi;

  @POST('api/auth/sessions/send_otp')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> sendOtp(@Body() Map<String, dynamic> data);


  @POST('api/auth/sessions/submit_otp')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> submitOtp(@Body() Map<String, dynamic> data);
}
