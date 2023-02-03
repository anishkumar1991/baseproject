import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Cubit/dashboard_cubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/CustomCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/horizontaltile/screens/DisplayList.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/socialcards/ImageCard.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/twitter/TwitterCard.dart';

import '../../Cubit/dashboard_state.dart';
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
                fontFamily: 'TwCenMT',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 20, 9),
              child: Container(
                width: 78,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9244),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text("Login",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 60),
          child: ListView(
            children: [
              DisplayList(),
              BlocBuilder<FetchPostsCubit, FetchPostsState>(
                  builder: (context, state) {
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
                      return SizedBox();
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
