import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/socialcards/CustomCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/horizontaltile/screens/DisplayList.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Values/app_colors.dart';
import '../../../../Values/icons.dart';
import '../../../../common/appstyle.dart';
import '../../homePage/widget/custom_drawer_widget.dart';
import 'cubit/FetchPostCubit.dart';
import 'cubit/FetchPostsState.dart';

class SocialMediaPage extends StatelessWidget {
  SocialMediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    cubit.fetchPosts();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.greyColor.withOpacity(0.1)),
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.bell),
                        onPressed: () {},
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Text("Social Media",
                        style: TextStyle(
                            fontFamily: 'Tw Cen MT',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
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
          ),
        ],
      ),
    ));
  }
}
