
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../reels/reels/cubits/ReelsCubit.dart';
import '../cubit/FetchPostCubit.dart';


Future<void> VideosShareURL(
    BuildContext context, int index, String sourceLink) async {
  final cubit = context.read<FetchPostsCubit>();
  String urlimage = cubit.tempModel!.posts[index!].postData.video.toString();
  var text1 = cubit.tempModel!.posts[index].title;
  var text2 = "https://mpsangathan.com/app";
  final sharecontent = "$text1\n\n$text2";

  String finalShare = urlimage+"\n\n"+sharecontent;
  await Share.share(finalShare);
  //await Share.shareXFiles(text: text, [file]);
}
