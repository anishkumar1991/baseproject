import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'create_guest_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrlForPravas)
abstract class CreateGuest {
  factory CreateGuest(Dio dio) = _CreateGuest;

  @POST('/backend/api/karyakram/attendees/list')
  Future<HttpResponse> GuestCreate(
      @Header('X-API-KEY') String apiKey,@Header('Authorization') String token, @Body() Map<String, dynamic> data);


  @GET('/backend/api/karyakram/attendees/list')
  Future<HttpResponse> getGuest(
      @Header('X-API-KEY') String apiKey);

}