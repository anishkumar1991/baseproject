import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'mandal_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrl)
abstract class GetDropDownValue {
  factory GetDropDownValue(Dio dio) = _GetDropDownValue;


  @GET('/zila/api/shakti_kendra/ac_mandals?ac={id}')
  Future<HttpResponse> getMandalValue(
      @Header('Authorization') String token, @Path('id') int id,);

  @GET('/zila/api/shakti_kendra/ac_booths?ac={id}')
  Future<HttpResponse> getBooth(
      @Header('Authorization') String token, @Path('id') int id);

  @POST("/zila/api/shakti_kendra/create_sk")
  Future<HttpResponse> createAndEditShaktiKendr(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);
}