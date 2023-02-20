import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'sangathan_details_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class DataLevelApi {
  factory DataLevelApi(Dio dio) = _DataLevelApi;

  @GET('/zila/api/data/level?check_permissions={status}&type={id}')
  Future<HttpResponse> getDataLevel(
      @Header('Authorization') String token,
      @Header('User-Agent') String agent,
      @Path('status') bool status,
      @Path('id') int id);

  @GET(
      '/zila/api/data/allotted_locations?client_id={clientId}&app_permission_id={permissionId}')
  Future<HttpResponse> allottedlocations(
    @Header('Authorization') String token,
    @Query('client_id') String clientId,
    @Query('app_permission_id') String permissionId,
  );

  @GET('/zila/api/data/client_app_permissions')
  Future<HttpResponse> getClientAppPermission(
      @Header('Authorization') String token,
      @Query("client_id") String clientId);
}
