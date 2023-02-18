import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelShareCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/cubits/ReelsCubit.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/share/ShareOnWhatsapp.dart';

import '../share/ReelURLShare.dart';
import '../share/sharingstorage.dart';

class OptionsScreen extends StatefulWidget {
  final int index;
  final String id;
  final String title;
  final String views;
  final String src;

  const OptionsScreen(
      {Key? key,
      required this.title,
      required this.views,
      required this.index,
      required this.src,
      required this.id})
      : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool reveal = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReelShareCubit>();
    final cubit1 = context.read<ReelsCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  SizedBox(
                    width: 260,
                    height: 100,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.title,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: Image.asset(
                            "assets/images/eye2.png",
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.views,
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: LikeButton(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              size: 20,
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                isLiked
                                    ? cubit.sendReelLike(cubit1
                                        .model!.reels[widget.index].id
                                        .toString())
                                    : null;
                                return Icon(
                                  Icons.thumb_up_alt,
                                  color: isLiked ? Colors.blue : Colors.white,
                                  size: 30,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16, right: 12),
                            child: Text(
                              "Like",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 3),
                      IconButton(
                          onPressed: () {
                            cubit.shareReelToWhatsapp(cubit1
                                .model!.reels[widget.index].id
                                .toString());
                            shareOnWhatsapp(
                                context, SocialMedia.whatsapp, widget.index);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          "Whatsapp",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      IconButton(
                          onPressed: () {
                            {
                              if (widget.src.contains('.m3u8') ||
                                  widget.src.contains('.M3U8') ||
                                  widget.src.contains('m3u8') ||
                                  widget.src.contains('M3U8')) {
                                cubit.shareReelToAll(
                                    "https://fluttercampus.com/sample.pdf");
                                ReelURLShare(context, widget.index, widget.src);
                                print(
                                    "------------- VIDEO FORMAT----->m3u8 not supported");
                              } else {
                                cubit.shareReelToAll(
                                    "https://fluttercampus.com/sample.pdf");
                                ReelDownloadshare(
                                    context, widget.index, widget.src);
                                print(
                                    "------------- VIDEO FORMAT----->supported format");
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          "Share",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
