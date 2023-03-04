import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/ReactionState.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/network/model/FetchPosts.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/Share.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/ShareOnWhatsapp.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/VideoShare.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/VideoShareURL.dart';
import 'package:sangathan/Values/string.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'ReactionButton.dart';
import 'cubit/FetchPostCubit.dart';
import 'cubit/ReactionCubit.dart';
import 'cubit/ShareCubit.dart';
import 'cubit/ShareState.dart';

class BottomSocialBar extends StatelessWidget {
  final int index;
  ScreenshotController? screenshotController = ScreenshotController();
  final List<Post> item;

  BottomSocialBar(
      {Key? key,
      required this.index,
      this.screenshotController,
      required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit2 = context.read<ShareCubit>();
    var id = item[index].id.toString();
    var shareToAllCount = item[index].shares.other;
    var shareToWhatsapp = item[index].shares.whatsapp;
    var reactCount = item[index].reactions[0].count;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              CustomReactionButton(
                index: index,
                id: id,
                item: item,
              ),
              const SizedBox(width: 10),
              BlocBuilder<ReactionCubit, ReactionState>(
                builder: (context, state) {
                  if (state is ReactionSend) {
                    reactCount = reactCount + 1;
                    return Text(
                      reactCount.toString(),
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    );
                  }
                  return Text(
                    reactCount.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    if (item[index].postType == "Poll") {
                      cubit2.shareToAll(id);
                      final text1 = item[index].title+"\n"+item[index].caption;
                      var text2 = AppStrings.shareUrl;

                      final text = "$text1\n\n$text2";



                      double pixelRatio =
                          MediaQuery.of(context).devicePixelRatio;
                      final image1 = await screenshotController!.capture(
                          pixelRatio: pixelRatio,
                          delay: const Duration(milliseconds: 10));
                      Uint8List bytes = image1!;
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final path = ('${directory.path}/image.png');
                      File(path).writeAsBytesSync(bytes);
                      XFile file = XFile(path);
                      await Share.shareXFiles(text: text, [file]);
                    } else if (item[index].postType == "Video") {
                      print("------------UNDER-Video-Type-----");
                      if (item[index]
                              .postData
                              .video
                              .toString()
                              .contains('.m3u8') ||
                          item[index]
                              .postData
                              .video
                              .toString()
                              .contains('.M3U8') ||
                          item[index]
                              .postData
                              .video
                              .toString()
                              .contains('m3u8') ||
                          item[index]
                              .postData
                              .video
                              .toString()
                              .contains('M3U8')) {
                        print("------------------VFORMAT---------------NO");
                        cubit2
                            .shareToAll(item[index].postData.video.toString());
                        VideosShareURL(
                            context,
                            index,
                            item[index].postData.video.toString(),
                            item[index].postData.video.toString(),
                            item[index].title,item[index].caption);
                      } else {
                        print(
                            "------------------VFORMAT---------------SUPPORTED");
                        cubit2
                            .shareToAll(item[index].postData.video.toString());
                        VideoDownloadShare(
                            context,
                            index,
                            item[index].postData.video.toString(),
                            item[index].postData.video.toString(),
                            item[index].title,item[index].caption);
                      }
                    } else {
                      print("----------------else ke andar FORMAT----->");
                      cubit2.shareToAll(id);
                      share(
                          context,
                          index,
                          item[index].postData.images!.first.toString(),
                          item[index].title,
                          item[index].caption);
                    }
                  },
                  icon: const Icon(Icons.share_outlined)),
              BlocBuilder<ShareCubit, ShareState>(
                builder: (context, state) {
                  if (state is SharedToAll) {
                    shareToAllCount = shareToAllCount + 1;
                    return Text(
                      shareToAllCount.toString(),
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    );
                  }
                  return Text(
                    shareToAllCount.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  );
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                cubit2.shareToWhatsapp(id);
                shareOnWhatsapp(
                    context, SocialMedia.whatsapp, index, item[index].title,item[index].caption);
              },
              icon: const Icon(FontAwesomeIcons.whatsapp,
                  color: Color(0xFF1FAF38)),
            ),
            BlocBuilder<ShareCubit, ShareState>(
              builder: (context, state) {
                if (state is SharedToWhatsapp) {
                  shareToWhatsapp = shareToWhatsapp + 1;
                  return Text(
                    shareToWhatsapp.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  );
                }
                return Text(
                  shareToWhatsapp.toString(),
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
