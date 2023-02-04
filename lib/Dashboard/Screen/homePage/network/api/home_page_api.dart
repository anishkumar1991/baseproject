import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../Values/string.dart';

part 'home_page_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class HomePageApi {
  factory HomePageApi(Dio dio) = _HomePageApi;

  @GET('/zila/api/data/client_app_lists')
  Future<HttpResponse> getClientAppLists(@Header('Authorization') String token);
}
