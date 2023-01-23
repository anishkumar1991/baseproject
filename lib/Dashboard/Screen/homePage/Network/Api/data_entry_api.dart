import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../Values/string.dart';

part 'data_entry_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class DataEntryApi {
  factory DataEntryApi(Dio dio) = _DataEntryApi;

  @POST('/zila/api/dashboard/karyakarta_report')
  Future<HttpResponse> getPersonList(
      @Header('Authorization') String token,
      @Body() Map<String, dynamic> data);
}
