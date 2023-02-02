import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String? auth =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZ2NVemFaYVRZeDhpaTV5ZXEyZ1FweW1XIn0.Xfj4HWx5fsixa__klS-b2-2zCUq7I8A18Rblhc0Boec";

  Future<void> fetchPosts() async {
    try {
      final res = await api.getPosts(auth!, "20");
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

  Future fetchTweets(BuildContext context, int index) async {
    var tempId = tempModel!.posts[index].postData.link?.url.toString();
    var splitted = tempId?.split('/');
    twitterId = splitted?[index].split('?')[0];
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
        tweetId: twitterId!.toString(),
        expansions: [v2.TweetExpansion.attachmentsMediaKeys],
        userFields: [v2.UserField.id],
        mediaFields: [v2.MediaField.url],
      );
      print(me.includes?.media?.first.url);

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
}
