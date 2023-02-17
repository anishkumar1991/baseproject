import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../../Values/string.dart';

part 'create_pravas_api.g.dart';

@RestApi(baseUrl: AppStrings.baseUrlForPravas)
abstract class CreatePravas {
  factory CreatePravas(Dio dio) = _CreatePravas;

  @FormUrlEncoded()
  @POST('/create_pravas')
  Future<HttpResponse> pravasCreate(
      @Field('name') String name,
      @Field('start_date') String startDate,
      @Field('end_date') String endDate,
      @Field('subject') String subject);
}
