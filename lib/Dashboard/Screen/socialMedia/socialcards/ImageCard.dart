import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../BottomSocialBar.dart';
import '../cubit/FetchPostCubit.dart';

class ImageCard extends StatelessWidget {
  final int? index;

  const ImageCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Image.network(
        cubit.tempModel!.posts[index!].postData.images!.first.toString(),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
