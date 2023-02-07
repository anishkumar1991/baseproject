// import 'package:dio/dio.dart' hide Headers;
// import 'package:retrofit/retrofit.dart';
//
// part 'ShareAPI.g.dart';
//
// @RestApi(baseUrl: "https://saral-social-staging.ccdms.in")
// abstract class ShareAPI {
//   factory ShareAPI(Dio dio) = _ShareAPI;
//
//   @POST("/api/mobile/v1/reels/share")
//   Future<HttpResponse> sendShare(
//       @Header('Authorization') String token, @Body() Map<String, dynamic> data);
//
//   @POST("/api/mobile/v1/reels/react")
//   Future<HttpResponse> share(
//       @Header('Authorization') String token, @Body() Map<String, dynamic> data);
// }
