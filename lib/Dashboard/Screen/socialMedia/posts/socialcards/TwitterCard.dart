import 'package:flutter/material.dart';
import 'dart:async';
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

class TwitterCard extends StatefulWidget {
  const TwitterCard({super.key});

  @override
  State<TwitterCard> createState() => _TwitterCardState();
}

class _TwitterCardState extends State<TwitterCard> {
  String? url = " ";
  String? text = " ";

  @override
  void initState() {
    tweetme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: const Color(0xFFE6E6E6), width: 1)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        child: Image.network(
                          url!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 20, top: 10),
                        child: Text(
                          text!,
                          style: const TextStyle(
                              fontFamily: 'TwCenMT',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 20, 10),
                      )
                    ],
                  )),
            ],
          )),
    );
  }

  void tweetme(BuildContext context) async {
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
        tweetId: "1620632164974080000",
        expansions: [v2.TweetExpansion.attachmentsMediaKeys],
        userFields: [v2.UserField.id],
        mediaFields: [v2.MediaField.url],
      );
      final tweetJson = me.data.toJson();
      final tweet = v2.TweetData.fromJson(tweetJson);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => CustomCard()));
      print(me.includes?.media?.first.url);
      print(me.data.text);
      print(me);

      setState(() {
        url = me.includes?.media?.first.url;
        text = me.data.text;
      });
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
