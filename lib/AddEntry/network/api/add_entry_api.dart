import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sangathan/Values/string.dart';
part 'add_entry_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class AddEntryApi {
  factory AddEntryApi(Dio dio) = _AddEntryApi;

  @GET('/zila/api/data/independent_dropdowns')
  Future<HttpResponse> getDropdownValues(@Header('Authorization') String token);

  @GET('/zila/api/data/caste?category_id={id}')
  Future<HttpResponse> getCast(
      @Header('Authorization') String token, @Path('id') String id);
}
