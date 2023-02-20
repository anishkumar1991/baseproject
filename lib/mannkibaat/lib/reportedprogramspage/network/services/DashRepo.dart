// import 'package:dio/dio.dart';
//
// import '../../../Storage/user_storage_service.dart';
// import '../model/dash_model.dart';
// import 'DashApi.dart';
//
// class DashRepo {
//   Future getEvents() async {
//     final api = DashApi(Dio(BaseOptions(
//         contentType: 'application/json', validateStatus: ((status) => true))));
//
//     String? token = StorageService.getUserAuthToken();
//
//     final res = await api.getEvents('auth_token $token');
//     DashModal model = DashModal.fromJson(res.data);
//     print('-------------Response Below 1-------------');
//
//     print('AIRED DETAILS ---${model.data!.first.airedDetail!.endDate}');
//     print('AIRED DETAILS ---${model.data!.first.airedDetail!.time}');
//     print('AIRED DETAILS ---${model.data!.first.airedDetail!.date}');
//
//     if (res.response.statusCode == 200) {
//       print('enetered');
//       print(model.data!.first.airedDetail?.time);
//     } else {
//       throw "Something Went Wrong!";
//     }
//   }
// }
