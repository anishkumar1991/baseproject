import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/reels/reels/Utils/Whatsapp.dart';

class OptionsScreen extends StatefulWidget {
  final String title;
  final String views;

  const OptionsScreen({Key? key, required this.title, required this.views})
      : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
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
                    height: 100,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.views,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                  // SizedBox(height: 10),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: LikeButton(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          size: 20,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.thumb_up_alt,
                              color:
                                  isLiked ? Colors.blue : Colors.white,
                              size: 30,
                            );
                          },
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //
                      //     },
                      //     icon: Icon(
                      //       Icons.thumb_up_alt,
                      //       color: Colors.white,
                      //     )),
                      SizedBox(height: 40),
                      IconButton(
                          onPressed: () {
                            shareOnWhatsapp(SocialMedia.whatsapp);
                          },
                          icon: Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          )),
                      SizedBox(height: 20),
                      IconButton(
                          onPressed: () {
                            shareOnWhatsapp(SocialMedia.whatsapp);
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          )),
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
