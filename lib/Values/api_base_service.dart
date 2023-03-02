import 'package:dio/dio.dart';
import 'package:sangathan/Values/string.dart';

import '../Storage/user_storage_service.dart';

class BaseService {
  static final dio = Dio(BaseOptions(baseUrl: AppStrings.baseUrl))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers
              .addAll({'Authorization': 'Bearer ${StorageService.userAuthToken}', 'Accept': 'application/json'});
          print("-----------------------------  DIO INTERCEPTOR --------------------------------------");
          print("Base URL   :${options.baseUrl}");
          print("Methods    :${options.method}");
          print("headers    :${options.headers}");
          handler.next(options);
        },
        onResponse: (e, handler) {
          print("Stats code :${e.extra}");
          print("URL        :${e.realUri}");
          print("Response   :${e.data}");
          print("-----------------------------  DIO INTERCEPTOR --------------------------------------");
          handler.next(e);
        },
        onError: (e, handler) {},
      ),
    );
}
