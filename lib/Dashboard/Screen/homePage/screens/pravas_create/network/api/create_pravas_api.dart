import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'create_pravas_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrlForPravas)
abstract class CreatePravas {
  factory CreatePravas(Dio dio) = _CreatePravas;

  @POST('/backend/api/pravas/list')
  Future<HttpResponse> PravasCreate(
  @Header('X-API-KEY') String apiKey,@Header('Authorization') String token, @Body() Map<String, dynamic> data);

}