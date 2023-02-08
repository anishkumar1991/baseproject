import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'mandal_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrl)
abstract class GetDropDownValue {
  factory GetDropDownValue(Dio dio) = _GetDropDownValue;


  @GET('/zila/api/data/required_locations?location_type=CountryState&location_id={id}&required_location_type=Mandal&zila_id={zilaId}')
  Future<HttpResponse> getMandalValue(
      @Header('Authorization') String token, @Path('id') int id, @Path('zilaId') int zilaId);

  @GET('/zila/api/shakti_kendra/ac_booths?ac={id}')
  Future<HttpResponse> getBooth(
      @Header('Authorization') String token, @Path('id') int id);
}