import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              SizedBox(
                height: 300,
              ),
              //We need swiper for every content
              BlocBuilder<ReelsCubit, ReelsState>(
                builder: (context, state) {
                  if (state is ReelsInitialState ||
                      state is ReelsLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ReelsFetchedState) {
                    print(state.reelsModel.reels.length);
                    return Swiper(
                      index: widget.index,

                      itemBuilder: (BuildContext context, int index) {
                        return ContentScreen(
                          src: state.reelsModel.reels[index].postData.reel,
                          title: state.reelsModel.reels[index].title,
                          views: state.reelsModel.reels[index].viewCount
                              .toString(),
                        );
                        // src: videos[index % videos.length]);
                      },
                      // preloadPagesCount: 4,
                      // itemCount: state.reelsModel.reels.length,
                      scrollDirection: Axis.vertical, itemCount: 4,
                    );
                  } else {
                    return Center(
                      child: Text('Error'),
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Reels',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
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
