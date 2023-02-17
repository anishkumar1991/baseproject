import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/zila/api/login')
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> data);

  @POST('/zila/api/resend_otp')
  Future<HttpResponse> resendOtp(@Body() Map<String, dynamic> data);

  @POST('/zila/api/submit_otp')
  Future<HttpResponse> submitOtp(
    @Body() Map<String, dynamic> data,
    @Header('User-Agent') String agent,
  );

  @POST('/zila/api/onboarding')
  Future<HttpResponse> userOnboarding(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @GET('/zila/api/logout')
  Future<HttpResponse> logOut(@Header('Authorization') String token);
}
