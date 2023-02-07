import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ReelsAPI.g.dart';

 @RestApi(baseUrl: "https://saral-social-staging.ccdms.in")
abstract class ReelsAPI {
  factory ReelsAPI(Dio dio) = _ReelsAPI;

  @GET('/api/mobile/v1/reels')
  Future<HttpResponse> getReels(@Header('Authorization') String token);
}
