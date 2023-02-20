import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'DashApi.g.dart';

@RestApi(baseUrl: "https://staging.mannkibaatprogram.in/")
abstract class DashApi {
  factory DashApi(Dio dio) = _DashApi;

  @GET('api/event_tracker/get_events')
  Future<HttpResponse> getEvents(@Header('Authorization') String token);
}
