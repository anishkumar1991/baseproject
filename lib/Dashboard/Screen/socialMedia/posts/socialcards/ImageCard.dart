import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/FetchPostCubit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCard extends StatefulWidget {
  final int? tempindex;

  const ImageCard({Key? key, required this.tempindex}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  int currpos = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        height: 400,
        child:
            cubit.tempModel!.posts[widget.tempindex!].postData.images!.length ==
                    1
                ? AspectRatio(
                    aspectRatio: 16 / 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cubit.tempModel!.posts[widget.tempindex!].postData
                            .images!.first
                            .toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: cubit.tempModel!.posts[widget.tempindex!]
                            .postData.images!.length,
                        itemBuilder: (context, index, realIndex) {
                          return AspectRatio(
                            aspectRatio: 16 / 12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                cubit.tempModel!.posts[widget.tempindex!]
                                    .postData.images![index]
                                    .toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currpos = index;
                            });
                          },

                          height: 370,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),-
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: cubit.tempModel!.posts[widget.tempindex!]
                            .postData.images!
                            .map((url) {
                          int index = cubit.tempModel!.posts[widget.tempindex!]
                              .postData.images!
                              .indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currpos == index
                                  ? const Color.fromRGBO(0, 0, 0, 0.9)
                                  : const Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
      ),
    );
  }
}
