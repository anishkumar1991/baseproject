// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sangathan/Storage/user_storage_service.dart';
//
// import 'NotificationState.dart';
//
// class NotificationCubit extends Cubit<NotificationState> {
//   String? twitterId;
//   FetchPosts? tempModel;
//   String? tweeturl;
//   String? tweettext;
//
//   NotificationCubit() : super(InitialNotificationState());
//   final api = FetchPostsApi(Dio(BaseOptions(
//       contentType: 'application/json', validateStatus: ((status) => true))));
//
//   Future<void> fetchNotification() async {
//     emit(NotificationFetchingState());
//     try {
//       final res =
//           await api.getPosts('Bearer ${StorageService.userAuthToken}', "25");
//       if (res.response.statusCode == 200) {
//         print("fetching notification api working");
//
//         FetchPosts model = FetchPosts.fromJson(res.data);
//         tempModel = model;
//         emit(NotificationFetchedState());
//         tempModel = model;
//
// // toString of Response's body is assigned to jsonDataString
//       } else {
//         emit(NotificationErrorState());
//       }
//     } on Exception catch (e) {
//       emit(NotificationErrorState());
//     }
//   }
// }
