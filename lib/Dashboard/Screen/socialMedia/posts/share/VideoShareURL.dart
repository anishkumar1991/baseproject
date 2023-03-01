
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Values/string.dart';
import 'package:share_plus/share_plus.dart';

import '../../reels/reels/cubits/ReelsCubit.dart';
import '../cubit/FetchPostCubit.dart';


Future<void> VideosShareURL(
    BuildContext context, int index, String sourceLink, String urlimage,var text1) async {
  final cubit = context.read<PostsCubit>();

  var text2 = AppStrings.shareUrl;
  final sharecontent = "$text1\n\n$text2";

  String finalShare = urlimage+"\n\n"+sharecontent;
  await Share.share(finalShare);
  //await Share.shareXFiles(text: text, [file]);
}
