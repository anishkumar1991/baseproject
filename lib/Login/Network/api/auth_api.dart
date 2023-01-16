import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: 'https://saral-staging.ccdms.in')
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;
  @POST('/zila/api/login')
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> data);

  @POST('/zila/api/resend_otp')
  Future<HttpResponse> resendOtp(@Body() Map<String, dynamic> data);

  @POST('/zila/api/submit_otp')
  Future<HttpResponse> submitOtp(@Body() Map<String, dynamic> data);

}
