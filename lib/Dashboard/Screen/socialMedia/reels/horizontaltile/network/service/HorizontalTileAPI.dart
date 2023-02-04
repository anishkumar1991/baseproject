import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'HorizontalTileAPI.g.dart';

@RestApi(baseUrl: "https://saral-social-staging.ccdms.in")
abstract class HorizontalTileAPI {
  factory HorizontalTileAPI(Dio dio) = _HorizontalTileAPI;

  @GET('/api/mobile/v1/reels')
  Future<HttpResponse> getReels(@Header('Authorization') String token);
}
