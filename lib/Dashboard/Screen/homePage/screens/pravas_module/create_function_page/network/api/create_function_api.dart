import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'create_function_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrlForPravas)
abstract class CreateFunction {
  factory CreateFunction(Dio dio) = _CreateFunction;

  @POST('/backend/api/karyakram/list')
  Future<HttpResponse> FunctionCreate(
  @Header('X-API-KEY') String apiKey,@Header('Authorization') String token, @Body() Map<String, dynamic> data);

}