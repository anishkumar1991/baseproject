import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/socialcards/CustomCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/horizontaltile/screens/DisplayList.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Values/app_colors.dart';
import 'cubit/FetchPostCubit.dart';
import 'cubit/FetchPostsState.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    cubit.fetchPosts();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text(
            "Social Media",
            style: TextStyle(
                fontFamily: 'Tw Cen MT',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 60),
          child: ListView(
            children: [
              DisplayList(),
              BlocBuilder<FetchPostsCubit, FetchPostsState>(
                  builder: (context, state) {
                if (state is FetchingPostsState) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor.withOpacity(0.3),
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: List.generate(
                                4,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        height: 152,
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
                      //   return CustomCardTwitter(index: index);
                      // }
                      if (state.model.posts[index].postType == "Image") {
                        return Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: CustomCard(tempkey: 2, index: index),
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
        ));
  }
}
