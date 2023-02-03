import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/stay_and_program_list/widgets/button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'cubit/FetchPostCubit.dart';
enum SocialMedia { whatsapp }

Future shareOnWhatsapp(BuildContext context, SocialMedia socialMedia, int index) async {
  final cubit = context.read<FetchPostsCubit>();
  String urlimage = cubit.tempModel!.posts[index].postData.images!.first
      .toString();
  final text = "${cubit.tempModel!.posts[index].title.toString()} \n\n";
  final url = Uri.parse(urlimage);
  final response = await http.get(url);
  final bytes = response.bodyBytes;
  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytesSync(bytes);
  XFile file = XFile(path);

  await Share.shareXFiles([file], text: text);
  //
  // final urls = {
  //   SocialMedia.whatsapp: 'whatsapp://send?text=$text',
  // };
  // final url1 = urls[socialMedia]!;
  //
  // launchUrl(Uri.parse(url1));
}
