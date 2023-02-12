import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../../../Values/string.dart';

part 'HorizontalTileAPI.g.dart';

@RestApi(baseUrl: AppStrings.socialmediabaseUrl)
abstract class HorizontalTileAPI {
  factory HorizontalTileAPI(Dio dio) = _HorizontalTileAPI;

  @GET('/api/mobile/v1/reels')
  Future<HttpResponse> getReels(@Header('Authorization') String token,@Query("size") String size);
}
