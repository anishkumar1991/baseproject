import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../Values/string.dart';

part 'user_detail_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrl)
abstract class UserDetailApi {
  factory UserDetailApi(Dio dio) = _UserDetailApi;

  @GET('/zila/api/data/user_profile_details')
  Future<HttpResponse> getDataLevel(
      @Header('Authorization') String token);

  @GET('/zila/api/data/independent_dropdowns')
  Future<HttpResponse> getDropdownValues(@Header('Authorization') String token);
}