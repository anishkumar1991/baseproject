import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';

part 'sangathan_details_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class DataLevelApi {
  factory DataLevelApi(Dio dio) = _DataLevelApi;

  @GET('/zila/api/data/level?check_permissions=true&type=1')
  Future<HttpResponse> getDataLevel(
    @Header('Authorization') String token,
    @Header('User-Agent') String agent,
  );

  @GET('/zila/api/data/allotted_locations')
  Future<HttpResponse> allottedlocations(@Header('Authorization') String token);
}
