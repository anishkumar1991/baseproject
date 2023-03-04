import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../../../../../../../Values/string.dart';

part 'ReelsAPI.g.dart';

@RestApi(baseUrl: AppStrings.socialmediabaseUrl)
abstract class ReelsAPI {
  factory ReelsAPI(Dio dio) = _ReelsAPI;

  @GET('/api/mobile/v1/reels')
  Future<HttpResponse> getReels(@Header('Authorization') String token,
      @Query("size") int size,@Query("page") int page);

  @POST("/api/mobile/v1/reels/react")
  Future<HttpResponse> sendReelLike(@Header('Authorization') String token,
      @Body() Map<String, dynamic> data);

  @POST("/api/mobile/v1/reels/share")
  Future<HttpResponse> shareReel(@Header('Authorization') String token,
      @Body() Map<String, dynamic> data);
}
