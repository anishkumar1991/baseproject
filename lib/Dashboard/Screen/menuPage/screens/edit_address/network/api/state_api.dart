import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../../Values/string.dart';

part 'state_api.g.dart';
@RestApi(baseUrl: AppStrings.baseUrlFOrState)
abstract class GetStateAPi {
  factory GetStateAPi(Dio dio) = _GetStateAPi;

  @GET('/core/world-cities/world-cities_json/data/5b3dd46ad10990bca47b04b4739a02ba/world-cities_json.json')
  Future<HttpResponse> getCountyState();
}