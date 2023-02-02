import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../Values/string.dart';

part 'data_entry_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class DataEntryApi {
  factory DataEntryApi(Dio dio) = _DataEntryApi;

  @POST('/zila/api/dashboard/karyakarta_report')
  Future<HttpResponse> getPersonList(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/zila/api/data_entry/party_zilas?state_id={id}')
  Future<HttpResponse> partyzilas(
      @Header('Authorization') String token, @Path('id') int id);

  @POST('/zila/api/dashboard/get_filter_options')
  Future<HttpResponse> getDataUnits(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/zila/api/data/deletion_reasons')
  Future<HttpResponse> getDeleteReason(@Header('Authorization') String token);

  @GET('/zila/api/data/delete_data_entry?id={id}&deletion_reason={reason}')
  Future<HttpResponse> deletePerson(@Header('Authorization') String token,
      @Path('id') int id, @Path('reason') String reason);
}
