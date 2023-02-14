import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/screens/ReelsMainPage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../Values/app_colors.dart';
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
    return Center(
      child: BlocBuilder<HorizontalTileCubit, HorizontalTileState>(
        builder: (context, state) {
          if (state is HorizontalTileLoading) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: AppColor.greyColor.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: List.generate(
                          4,
                          (index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(right: 20),
                                height: 152,
                                width: 117,
                              )).toList(),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is HorizontalTileFetchedState) {
            return Container(
              height: 152,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Flexible(
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 5) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomePage(
                                                index: 5,
                                              )));
                                },
                                child: SizedBox(
                                  height: 169,
                                  width: 117,
                                  child: Card(
                                    elevation: 4,
                                    color: AppColor.cardOrangeColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("View More",
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        const Icon(Icons.arrow_forward, size: 25)
                                      ],
                                    )),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  HomePage(
                                                index: index,
                                              )));
                                },
                                child: ContentCard(
                                  views: state.htModel.reels[index].title,
                                  title: state.htModel.reels[index].viewCount
                                      .toString(),
                                  img: state.htModel.reels[index].postData
                                      .thumbnailUrl,
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is HorizontalTileError) {
            return Text(state.error);
          }
          return Center(
            child: Shimmer.fromColors(
              baseColor: AppColor.greyColor.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: List.generate(
                        4,
                        (index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              height: 152,
                              width: 117,
                            )).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
