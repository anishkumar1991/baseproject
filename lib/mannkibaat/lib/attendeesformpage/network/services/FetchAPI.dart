import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'FetchAPI.g.dart';

@RestApi(baseUrl: "https://staging.mannkibaatprogram.in/")
abstract class FetchAPI {
  factory FetchAPI(Dio dio) = _FetchAPI;

  @GET('api/event_tracker/get_country_state')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> fetchStates(
      @Header('Authorization') Map<String, dynamic> token);

  @POST('api/event_tracker/get_acs')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> fetchAc(
      @Header('Authorization') token, @Field("country_state_id") String data);

  @POST('api/event_tracker/get_booth')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> fetchBooth(
      @Header('Authorization') token, @Field("ac_id") String data);
}
