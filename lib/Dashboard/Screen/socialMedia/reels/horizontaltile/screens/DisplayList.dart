import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/screens/ReelsMainPage.dart';
import '../cubit/HorizontalTileCubit.dart';
import '../cubit/HorizontalTileState.dart';
import 'ContentCard.dart';

class DisplayList extends StatefulWidget {
  const DisplayList({Key? key}) : super(key: key);

  @override
  State<DisplayList> createState() => _DisplayListState();
}

class _DisplayListState extends State<DisplayList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<HorizontalTileCubit>().getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: BlocBuilder<HorizontalTileCubit, HorizontalTileState>(
          builder: (context, state) {
            if (state is HorizontalTileInitialState ||
                state is HorizontalTileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HorizontalTileFetchedState) {
              return Container(
                height: 152,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: state.htModel.reels.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          index: index,
                                        )));
                          },
                          child: ContentCard(
                            views: state.htModel.reels[index].title,
                            title:
                                state.htModel.reels[index].viewCount.toString(),
                            img: state
                                .htModel.reels[index].postData.thumbnailUrl,
                          ),
                        );
                      }),
                ),
              );
            } else {
              return Text('error');
            }
          },
        ),
      );

  }
}
