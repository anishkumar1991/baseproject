import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'add_entry_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class AddEntryApi {
  factory AddEntryApi(Dio dio) = _AddEntryApi;

  @GET('/zila/api/data/independent_dropdowns')
  Future<HttpResponse> getDropdownValues(@Header('Authorization') String token);

  @GET('/zila/api/data/caste?category_id={id}&level={level}&level_name={level_name}')
  Future<HttpResponse> getCast(@Header('Authorization') String token, @Path('id') String id,
      @Path('level') String level, @Path('level_name') level_name);

  @GET('/zila/api/data_entry/party_zilas?state_id={countryID}')
  Future<HttpResponse> getDistrictDropdownData(
      @Header('Authorization') String token, @Path('countryID') String countryID);

  /// TODO : For now type id is static need to make dynamic
  @GET('/zila/api/data_entry/form_structure?level_id={levelID}&type_id=1&country_state_id={countryStateId}&is_app=true')
  Future<HttpResponse> getAddEntryFormStructure(@Header('Authorization') String token,
      @Header('User-Agent') String userAgent, @Path('levelID') String levelID, @Path('countryStateId') countryStateId);

  @POST('/zila/api/dashboard/get_filter_options')
  Future<HttpResponse> getDesignation(@Header('Authorization') String token, @Body() Map<String, dynamic> data);

  @POST('/zila/api/data_entry/create')
  Future<HttpResponse> submitAddEntry(@Header('Authorization') String token, @Body() Map<String, dynamic> data);
}
