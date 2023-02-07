import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'vidhanSabha_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrl)
abstract class GetDropDownValue {
  factory GetDropDownValue(Dio dio) = _GetDropDownValue;


  @GET('/zila/api/data/required_locations?location_type=CountryState&location_id={id}&required_location_type=AssemblyConstituency')
  Future<HttpResponse> getVidhanSabhaValue(
      @Header('Authorization') String token, @Path('id') int id);
}