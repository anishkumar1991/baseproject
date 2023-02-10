import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../Values/string.dart';
part 'verify_person_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class VerifyPersonApi {
  factory VerifyPersonApi(Dio dio) = _VerifyPersonApi;

  @GET('/zila/api/data/person/generate_otp?person_id={id}')
  Future<HttpResponse> sendOTP(
      @Header('Authorization') String token, @Path('id') int id);

  // @GET('/zila/api/data/person/resend_otp')
  // Future<HttpResponse> reSendOTP(@Header('Authorization') String token);
}
