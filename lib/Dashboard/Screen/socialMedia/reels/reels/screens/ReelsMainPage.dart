import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../posts/cubit/FetchPostCubit.dart';
import '../cubits/ReelsCubit.dart';
import '../cubits/ReelsState.dart';
import '../network/model/ReelsModel.dart';
import 'Content.dart';

class HomePage extends StatefulWidget {
  final int index;

  const HomePage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final swipecontroller = SwiperController();

  @override
  void initState() {
    BlocProvider.of<ReelsCubit>(context).loadReel();

    swipecontroller.addListener(() {
      BlocProvider.of<ReelsCubit>(context).loadReel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black45,
          child: Stack(
            children: [
              const SizedBox(
                height: 300,
              ),
              //We need swiper for every content
              BlocBuilder<ReelsCubit, ReelsState>(
                builder: (context, state) {
                  if (state is PostsLoading && state.isFirstFetch) {
                    return _loadingIndicator();
                  }
                  List<Reel> posts = [];
                  bool isLoading = false;
                  if (state is PostsLoading) {
                    posts = state.oldPosts;
                    isLoading = true;
                  } else if (state is PostsLoaded) {
                    posts = state.posts;
                  }

                  return Swiper(
                    itemCount: posts.length + (isLoading ? 1 : 0),
                    index: widget.index,
                    controller: swipecontroller,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < posts.length) {
                        return ContentScreen(
                          item: posts,
                          src: posts[index].postData.reel,
                          title: posts[index].title,
                          views: posts[index].viewCount.toString(),
                          index: index,
                          id: posts[index].id.toString(),
                        );
                      } else {
                        return const Text("End of Data");
                      }
                    },
                    scrollDirection: Axis.vertical,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlurryContainer(
                      borderRadius: BorderRadius.zero,
                      blur: 1,
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  enableFeedback: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Reels',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                '',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
