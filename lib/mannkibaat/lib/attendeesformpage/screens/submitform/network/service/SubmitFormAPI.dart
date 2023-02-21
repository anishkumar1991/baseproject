import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'SubmitFormAPI.g.dart';

@RestApi(baseUrl: "https://staging.mannkibaatprogram.in/")
abstract class SubmitFormAPI {
  factory SubmitFormAPI(Dio dio) = _SubmitFormAPI;


  @POST('api/event_tracker/create_event_details')
  @Headers({"Content-Type": "application/json", "Accept": 'application/json'})
  Future<HttpResponse> postForm(
      @Header('Authorization') token,  @Body() Map<String, dynamic> data);
}
