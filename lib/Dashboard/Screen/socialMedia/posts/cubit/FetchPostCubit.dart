import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/user_storage_service.dart';

import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

import '../network/model/FetchPosts.dart';
import '../network/services/FetchPostsApi.dart';
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
          await api.getPosts('Bearer ${StorageService.userAuthToken}', "25");
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

  Future<void> fetchTweets(int index) async {
    print("index $index");
    var tempId = tempModel!.posts[index].postData.link?.url.toString();
    var splitted = tempId?.split('/');
    twitterId = splitted?[5].split('?')[0];
    print("twitter id = $twitterId");

    //! You need to get keys and tokens at https://developer.twitter.com
    final twitter = v2.TwitterApi(
      bearerToken:
          'AAAAAAAAAAAAAAAAAAAAAIyLlQEAAAAAdmRh66gedzI%2FfCfrGAWPs4fIMAo%3DENXXDtotwUdreypsH3wlEWchvzHWVV6lzJtyrckcoSwnxBjpaw',
      oauthTokens: const v2.OAuthTokens(
        consumerKey: 'Ema3qx5xHO3p8Ltd8zbYer2pZ',
        consumerSecret: 'zDKdYGZIkEjJHKU6AWLg4kVIhBwEqMc9RwOwlz5PzJ6JFbZJBx',
        accessToken: '833907573254414336-OmwFTl188FxOmnZ4leDSW4SE9V5RqHp',
        accessTokenSecret: 'kHCOY0Ld0Q1uG8q9C9u84cQeuK2g9lBXgD0f7GLqP1hI5',
      ),
      retryConfig: v2.RetryConfig(
        maxAttempts: 5,
        onExecute: (event) => print(
          'Retry after ${event.intervalInSeconds} seconds... '
          '[${event.retryCount} times]',
        ),
      ),

      //! The default timeout is 10 seconds.
      timeout: const Duration(seconds: 20),
    );
    try {
      final me = await twitter.tweets.lookupById(
        tweetId: twitterId!,
        expansions: [v2.TweetExpansion.attachmentsMediaKeys],
        userFields: [v2.UserField.id],
        mediaFields: [v2.MediaField.url],
      );

      print("url = ${me.includes?.media?.first.url}");
      print(me.includes?.tweets?.first.text.toString());

      tweeturl = me.includes?.media?.first.url.toString();

      tweettext = me.includes?.tweets?.first.text.toString();
    } on TimeoutException catch (e) {
      print(e);
    } on v2.UnauthorizedException catch (e) {
      print(e);
    } on v2.RateLimitExceededException catch (e) {
      print(e);
    } on v2.DataNotFoundException catch (e) {
      print(e);
    } on v2.TwitterUploadException catch (e) {
      print(e);
    } on v2.TwitterException catch (e) {
      print(e.response.headers);
      print(e.body);
      print(e);
    }
  }

  Future<void> sendLike(String postId) async {
    try {
      final res = await api.sendLike('Bearer ${StorageService.userAuthToken}',
          {"post_id": postId, "reaction": "like"});
      if (res.response.statusCode == 200) {
        print("like button api working");
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
