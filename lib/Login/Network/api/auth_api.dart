import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/Auth/login')
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> data);

}
