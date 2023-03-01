import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/network/model/FetchPosts.dart';
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
  final scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<PostsCubit>(context).loadPosts();

    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<PostsCubit>(context).loadPosts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: scrollController,
              children: [
                const DisplayList(),
                BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
                  // if (state is FetchingPostsState) {
                  //   return Center(
                  //     child: Shimmer.fromColors(
                  //       baseColor: AppColor.greyColor.withOpacity(0.3),
                  //       highlightColor: Colors.grey.withOpacity(0.1),
                  //       child: SingleChildScrollView(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 5, right: 5),
                  //           child: Column(
                  //             children: List.generate(
                  //                 5,
                  //                     (index) => Padding(
                  //                   padding: const EdgeInsets.only(top: 10),
                  //                   child: Container(
                  //                     decoration: const BoxDecoration(
                  //                       color: Colors.white,
                  //                     ),
                  //                     height: 250,
                  //                   ),
                  //                 )).toList(),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }
                  if (state is PostsLoading && state.isFirstFetch) {
                    return _loadingIndicator();
                  }
                  List<Post> posts = [];
                  bool isLoading = false;
                  if (state is PostsLoading) {
                    posts = state.oldPosts;
                    isLoading = true;
                  } else if (state is PostsLoaded) {
                    posts = state.posts;
                  }
                  print("post lenght ${posts.length}");
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: posts.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < posts.length) {
                        if (posts[index].postType == "Image") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: CustomCard(
                                tempkey: 2, index: index, item: posts),
                          );
                        } else if (posts[index].postType == "Poll") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Polls(tempindex: index, item: posts),
                          );
                        } else if (posts[index].postType == "Video") {
                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: VideoCard(index: index, item: posts),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }

                      return const Text("Ent Of Data");
                    },
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

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
