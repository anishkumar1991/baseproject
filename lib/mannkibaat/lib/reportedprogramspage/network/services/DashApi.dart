import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../Values/string.dart';

part 'DashApi.g.dart';

@RestApi(baseUrl: AppStrings.baseUrlMannKiBaat)
abstract class DashApi {
  factory DashApi(Dio dio) = _DashApi;

  @GET('api/event_tracker/get_events')
  Future<HttpResponse> getEvents(@Header('Authorization') String token);
}
