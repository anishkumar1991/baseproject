import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/cubit/FetchPostCubit.dart';
import 'Share.dart';
import 'ShareOnWhatsapp.dart';
import 'cubit/ThumbCubit.dart';
import 'cubit/ThumbState.dart';

class BottomSocialBar extends StatelessWidget {
  final String? url;
  final int index;

  const BottomSocialBar({Key? key, this.url, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit1 = context.read<FetchPostsCubit>();
    late int temp = 0;

    final cubit = context.read<ThumbCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              BlocListener<ThumbCubit, ThumbState>(
                listener: (context, state) {
                  if (state is InitialState) {
                    temp = 1;
                  }
                  if (state is ThumbPressedState) {
                    temp = 2;
                  }
                  if (state is ThumbNotPressedState) {
                    temp = 3;
                  }
                },
                child: IconButton(
                  onPressed: () {
                    if (temp == 1) {
                      cubit.thumbPressed();
                    } else if (temp == 2) {
                      cubit.thumbNotPressed();
                    } else if (temp == 3) {
                      cubit.thumbPressed();
                    } else {
                      cubit.thumbPressed();
                    }
                  },
                  icon: BlocBuilder<ThumbCubit, ThumbState>(
                    builder: (context, state) {
                      if (state is ThumbPressedState) {
                        return const Icon(
                          Icons.thumb_up_alt,
                          color: Colors.blue,
                        );
                      }
                      if (state is ThumbNotPressedState) {
                        return const Icon(Icons.thumb_up_off_alt);
                      }
                      return const Icon(Icons.thumb_up_off_alt);
                    },
                  ),
                ),
              ),
              Text(
                  cubit1.tempModel!.posts[index].reactions[0].count.toString()),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    share(context, url!);
                  },
                  icon: const Icon(Icons.share_outlined)),
              Text(cubit1.tempModel!.posts[index].shares.other.toString()),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                shareOnWhatsapp(SocialMedia.whatsapp);
              },
              icon: const Icon(Icons.whatsapp, color: Color(0xFF1FAF38)),
            ),
            Text(cubit1.tempModel!.posts[index].shares.whatsapp.toString()),
          ],
        ),
      ],
    );
  }
}
