import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../Values/string.dart';

part 'update_personal_details.g.dart';
@RestApi(baseUrl: AppStrings.baseUrl)
abstract class UpdatePersonalDetailsApi {
  factory UpdatePersonalDetailsApi(Dio dio) = _UpdatePersonalDetailsApi;

  @POST('/zila/api/data/users_profile')
  Future<HttpResponse> updatePersonalDetails(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/zila/api/data/caste?category_id={id}')
  Future<HttpResponse> getCast(
      @Header('Authorization') String token, @Path('id') String id);
}