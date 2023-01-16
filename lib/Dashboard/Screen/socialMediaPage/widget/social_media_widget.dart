import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.greyColor.withOpacity(0.3))),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image.asset(
                  AppIcons.socialPageImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.redColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.visibility_outlined,
                          color: AppColor.white,
                          size: 16,
                        ),
                        Text(
                          'Live 3.2k',
                          style: TextStyle(
                              fontFamily: 'Tw Cen MT',
                              fontSize: 12,
                              color: AppColor.white),
                        )
                      ]),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.white, width: 3)),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColor.white,
                    size: MediaQuery.of(context).size.width * 0.10,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                Text(
                  'People’s PollNobody can break Modi-Yogi Pair: UP governor',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Tw Cen MT',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 14,
                ),
                ReadMoreText(
                  'Uttar Pradesh Governor Anandiben Patel on Sunday said nobody available on branch on give by leader ',
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  style: TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 18,
                      color: AppColor.greyColor),
                  trimCollapsedText: 'More',
                  trimExpandedText: 'Less',
                  lessStyle: TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 18,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w700),
                  moreStyle: TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 18,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppIcons.likeIcon,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '1k',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.share_outlined,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '223',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    AppIcons.whatsappIcon,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '223',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
