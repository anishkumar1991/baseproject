import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
part 'LikeButtonAPI.g.dart';

@RestApi(baseUrl: 'https://saral-social-staging.ccdms.in/')
abstract class LikeButtonAPI {
  factory LikeButtonAPI(Dio dio) = _LikeButtonAPI;

  @POST('/api/mobile/v1/reels/react')
  Future<HttpResponse> likesData(
      @Header("Authorization") String auth, @Body() Map<String, dynamic> data);
}
