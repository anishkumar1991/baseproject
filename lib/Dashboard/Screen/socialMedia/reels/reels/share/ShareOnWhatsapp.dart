import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelsCubit.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { whatsapp }

Future shareOnWhatsapp(
    BuildContext context, SocialMedia socialMedia, int index) async {
  final cubit = context.read<ReelsCubit>();
  // String urlimage = cubit.tempModel!.posts[index].postData.images!.first
  //     .toString();
  final text = cubit.model!.reels[index].sharingContent;
  // final url = Uri.parse(urlimage);
  // final response = await http.get(url);
  // final bytes = response.bodyBytes;
  // final temp = await getTemporaryDirectory();
  // final path = '${temp.path}/image.jpg';
  // File(path).writeAsBytesSync(bytes);
  // XFile file = XFile(path);
  //
  // await Share.shareXFiles([file], text: text);

  final urls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=$text',
  };
  final url1 = urls[socialMedia]!;
  launchUrl(Uri.parse(url1));
}
