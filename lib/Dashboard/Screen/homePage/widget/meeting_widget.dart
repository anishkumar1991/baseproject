import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDEBCE),
              Color(0xFFE9C9E3),
            ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Stack(
              children: [
                Image.asset(
                  AppIcons.meetingImage,
                  fit: BoxFit.fitWidth,
                  height: 80,
                  width: double.infinity,
                ),
                Image.asset(
                  AppIcons.backGroundImage,
                  fit: BoxFit.fitWidth,
                  height: 80,
                  width: double.infinity,
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  child: Text(
                    'Meeting',
                    style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor().buttonTextColor),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  child: Text(
                    'Narendra Modi',
                    style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.green200),
                  ),
                ),
                Positioned(
                    right: 5,
                    top: 10,
                    child: Image.asset(
                      AppIcons.arrowForward,
                      fit: BoxFit.fill,
                      height: 24,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Member',
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColor.navyBlue),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Image.asset(
                          AppIcons.memberImage,
                          fit: BoxFit.cover,
                          width: 49,
                          height: 49,
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: Image.asset(
                          AppIcons.memberImage,
                          fit: BoxFit.cover,
                          width: 49,
                          height: 49,
                        ),
                      ),
                      Positioned(
                        left: 80,
                        child: Image.asset(
                          AppIcons.memberImage,
                          fit: BoxFit.cover,
                          width: 49,
                          height: 49,
                        ),
                      ),
                      Positioned(
                        left: 120,
                        child: CircleAvatar(
                          backgroundColor: AppColor.navyBlue400,
                          radius: 25,
                          child: Text(
                            '+40',
                            style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: AppColor.textBlackColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '24 Dec, 2022',
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textBlackColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      '10:00 AM to 12:00 PM  ',
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.greyColor),
                    ),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.greyColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '1H',
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.greyColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: (() {}),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'Join',
                        style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textBlackColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
