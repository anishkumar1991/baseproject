import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'create_function_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrlForPravas)
abstract class CreateFunction {
  factory CreateFunction(Dio dio) = _CreateFunction;

  @FormUrlEncoded()
  @POST('/create_program')
  Future<HttpResponse> functionCreate(
    @Header('Authorization') String token,
    @Field('name') String name,
    @Field('date') String date,
    @Field('time') String time,
    @Field('location') String location,
    @Field('place') String place,
    @Field('subject') String subject,
    @Field('summary') String summary,
    @Field('pravas_id') String pravasId,
    @Field('level_id') String levelId,
  );

  @GET('/program_type')
  Future<HttpResponse> programType(@Header('Authorization') String token);

  @GET('/data_levels')
  Future<HttpResponse> programLevel(@Header('Authorization') String token);
}
