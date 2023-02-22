import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'vidhanSabha_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class GetDropDownValue {
  factory GetDropDownValue(Dio dio) = _GetDropDownValue;

  @GET(
      '/zila/api/data/required_locations?location_type={locationType}&location_id={id}&required_location_type=AssemblyConstituency')
  Future<HttpResponse> getVidhanSabhaValue(
      @Header('Authorization') String token,
      @Path('id') int id,
      @Path('locationType') String locationType);

  @GET('/zila/api/shakti_kendra/ac_sks_with_booths?ac={id}')
  Future<HttpResponse> getShaktiKenr(
      @Header('Authorization') String token, @Path('id') int id);

  @GET(
      '/api/v1/shakti_kendras/delete?shakti_kendra_id={id}&confirm_delete={isConfirm}')
  Future<HttpResponse> deleteShaktiKendr(@Header('Authorization') String token,
      @Path('id') int id, @Path('isConfirm') bool isConfirm);
}
