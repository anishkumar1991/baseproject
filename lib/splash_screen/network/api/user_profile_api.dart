import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'user_profile_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class UserProfileApi {
  factory UserProfileApi(Dio dio) = _UserProfileApi;

  @GET('/zila/api/data/user_profile_details')
  Future<HttpResponse> getUserProfileDetails(
      @Header('Authorization') String token);
}
