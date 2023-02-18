import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/SendFcmTokenCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/SendFcmTokenState.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/socialcards/CustomCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/socialcards/Polls.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/topBar.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/horizontaltile/screens/DisplayList.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Values/app_colors.dart';
import 'cubit/FetchPostCubit.dart';
import 'cubit/FetchPostsState.dart';
import 'socialcards/VideoCard.dart';

class SocialMediaPage extends StatefulWidget {
  SocialMediaPage({Key? key}) : super(key: key);

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  @override
  void initState() {
    super.initState();
  }

  // fucntion to send fcm token to api
  Future<void> sendfcmtoken() async {
    // final fcmcubit = context.read<SendFcmTokenCubit>();
    // await fcmcubit.sendFcm(StorageService.getUserFcmToken());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    cubit.fetchPosts();
    print("user fcm token previous ${StorageService.getUserFcmToken()}");

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBar(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                const DisplayList(),
                BlocBuilder<FetchPostsCubit, FetchPostsState>(
                    builder: (context, state) {
                  if (state is FetchingPostsState) {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: AppColor.greyColor.withOpacity(0.3),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: List.generate(
                                  5,
                                  (index) => Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          height: 250,
                                        ),
                                      )).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is PostsFetchedState) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: state.model.posts.length,
                      itemBuilder: (context, index) {
                        // if (state.model.posts[index].postType == "Link" &&
                        //     state.model.posts[index].postData.link?.linkType ==
                        //         "twitter") {
                        //   return TwitterCard();
                        // }
                        if (state.model.posts[index].postType == "Image") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: CustomCard(tempkey: 2, index: index),
                          );
                        }
                        if (state.model.posts[index].postType == "Poll") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Polls(tempindex: index),
                          );
                        }

                        if (state.model.posts[index].postType == "Video") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: VideoCard(index: index),
                          );
                        }

                        return const SizedBox();
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
