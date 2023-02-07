import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ViewCountAPI.g.dart';

@RestApi(baseUrl: "https://saral-social-staging.ccdms.in ")
abstract class ViewCountAPI {
  factory ViewCountAPI(Dio dio) = _ViewCountAPI;

  @POST("/api/mobile/v1/reels/view_reel")
  Future<HttpResponse> sendViews(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);
}
