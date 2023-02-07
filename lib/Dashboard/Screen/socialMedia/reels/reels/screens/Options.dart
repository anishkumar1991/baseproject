import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class OptionsScreen extends StatefulWidget {
  final int index;
  final String title;
  final String views;

  const OptionsScreen(
      {Key? key, required this.title, required this.views, required this.index})
      : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool reveal = false;

  Widget build(BuildContext context) {
    // final cubit1 = context.read<ReelsCubit>();
    // final cubit2 = context.read<ReelShareCubit>();
    // var id = cubit1.model?.reels[widget.index].id.toString();
    // var shareToAllCount = cubit1.model!.reels[widget.index].shares.other;
    // var shareToWhatsapp = cubit1.model!.reels[widget.index].shares.whatsapp;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Container(

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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                          width: 16,
                          height: 16,
                          child: Image.asset(
                            "assets/images/eye2.png",
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
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
                              circleColor: CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.thumb_up_alt,
                                  color: isLiked ? Colors.blue : Colors.white,
                                  size: 30,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, right: 12),
                            child: Text(
                              "Like",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 3),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          )),
                      // BlocBuilder<ShareCubit, ShareState>(
                      //   builder: (context, state) {
                      //     if (state is SharedToWhatsapp) {
                      //       shareToWhatsapp = shareToWhatsapp + 1;
                      //       return Text(shareToWhatsapp.toString());
                      //     }
                      //     return Text(shareToWhatsapp.toString());
                      //   },
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          "Whatsapp",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 4),
                      IconButton(
                          onPressed: () {
                            // cubit2.shareToWhatsapp(id!);
                            // shareToWhatsapp;
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          )),
                      // BlocBuilder<ShareCubit, ShareState>(
                      //   builder: (context, state) {
                      //     if (state is SharedToAll) {
                      //       shareToAllCount = shareToAllCount + 1;
                      //       return Text(shareToAllCount.toString());
                      //     }
                      //     return Text(shareToAllCount.toString());
                      //   },
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          "Share",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 150),
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
