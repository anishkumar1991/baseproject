import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../posts/cubit/FetchPostCubit.dart';
import '../cubits/ReelsCubit.dart';
import '../cubits/ReelsState.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<ReelsCubit>().getReelsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostsCubit>();
    // cubit.fetchPosts();
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
                  if (state is ReelsInitialState ||
                      state is ReelsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReelsFetchedState) {
                    return Swiper(
                      index: widget.index,
                      controller: SwiperController(),
                      itemBuilder: (BuildContext context, int index) {
                        return ContentScreen(
                          src: state.reelsModel.reels[index].postData.reel,
                          title: state.reelsModel.reels[index].title,
                          views: state.reelsModel.reels[index].viewCount
                              .toString(), index: index, id: state.reelsModel.reels[index].id.toString(),
                        );
                        // src: videos[index % videos.length]);
                      },

                      scrollDirection: Axis.vertical, itemCount: state.reelsModel.reels.length,
                    );
                  } else {
                    return const Center(
                      child: Text('Something Went Wrong'),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlurryContainer(
                      borderRadius: BorderRadius.zero,
                      blur: 20,
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
                          // Expanded(
                          //   flex: 4,
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: IconButton(
                          //       onPressed: () {
                          //         enableFeedback:
                          //         false;
                          //       },
                          //       icon: Icon(
                          //         Icons.volume_up,
                          //       ),
                          //     ),
                          //   ),
                          // )
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
}