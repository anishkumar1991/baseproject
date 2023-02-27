import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import '../network/model/FetchPosts.dart';
import '../network/services/fetchposts/FetchPostsApi.dart';
import 'FetchPostsState.dart';

class FetchPostsCubit extends Cubit<FetchPostsState> {
  String? twitterId;
  FetchPosts? tempModel;
  String? tweeturl;
  String? tweettext;

  FetchPostsCubit() : super(InitialFetchPostState());
  final api = FetchPostsApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));

  Future<void> fetchPosts() async {
    emit(FetchingPostsState());
    try {
      final res =
      await api.getPosts('Bearer ${StorageService.userAuthToken}', {"size": "30"});
      if (res.response.statusCode == 200) {
        print("api working");

        FetchPosts model = FetchPosts.fromJson(res.data);
        tempModel = model;
        emit(PostsFetchedState(model));

        tempModel = model;

// toString of Response's body is assigned to jsonDataString
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}