import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'FetchPostsApi.g.dart';

@RestApi(baseUrl: "https://saral-social-staging.ccdms.in")
abstract class FetchPostsApi {
  factory FetchPostsApi(Dio dio) = _FetchPostsApi;

  @GET('/api/mobile/v1/posts')
  Future<HttpResponse> getPosts(
      @Header('Authorization') String token, @Query("size") String size);

  @POST("/api/mobile/v1/posts/react")
  Future<HttpResponse> sendLike(
      @Header('Authorization') String token, @Body() Map<String, dynamic> data);
}
