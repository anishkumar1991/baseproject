import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/widget/customListview.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/size_config.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().getCurrentOrientation(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppIcons.notification,
                      height: 32,
                      width: 32,
                    ),
                    Image.asset(
                      AppIcons.sangathanLogo,
                      height: 55,
                      width: 55,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppIcons.personImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.borderColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Image.asset(
                        AppIcons.searchicon,
                        height: 17,
                        width: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 25,
                          width: double.infinity,
                          child: TextField(
                            controller: searchTextController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8),
                                border: InputBorder.none,
                                hintText: 'प्रवास और  कार्याक्रम देखे',
                                hintStyle: GoogleFonts.poppins(
                                    color: AppColor.borderColor, fontSize: 14)),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        AppIcons.micicon,
                        height: 18,
                        width: 14,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: SizeConfig.screenWidth! * 0.94,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.cardOrangeColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 16),
                          child: Text(
                            'संगठन',
                            style: GoogleFonts.poppins(
                                color: AppColor.textBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          bottom: SizeConfig.screenHeight! * 0.03,
                          left: 5,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  backgroundColor:
                                      AppColor.buttonBackGroundColor),
                              onPressed: (() {}),
                              child: Text(
                                'क्लिक करें',
                                style: GoogleFonts.poppins(
                                    color: AppColor().buttonTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                        Positioned(
                          top: 10,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            AppIcons.sangathanCardImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.pravasCradColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Pravas',
                            style: TextStyle(
                                fontFamily: 'Tw Cen MT',
                                color: AppColor.textBlackColor,
                                fontSize: 20),
                          ),
                          const Spacer(),
                          const Text(
                            'See pravas list',
                            style: TextStyle(
                                fontFamily: 'Tw Cen MT',
                                color: AppColor.textBlackColor,
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: AppColor.iconBackGroudColor,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.expand_more),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor().buttonTextColor),
                        child: IntrinsicHeight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Total Pravas',
                                      style: TextStyle(
                                          fontFamily: 'Tw Cen MT',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.naturalBlackColor),
                                    ),
                                    Text(
                                      '5',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textBlackColor),
                                    )
                                  ],
                                ),
                                const VerticalDivider(
                                  indent: 6,
                                  endIndent: 6,
                                  color: AppColor.borderColor,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Total Karyakram',
                                      style: TextStyle(
                                          fontFamily: 'Tw Cen MT',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.naturalBlackColor),
                                    ),
                                    Text('2',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.textBlackColor))
                                  ],
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'My events',
                      style: TextStyle(
                          fontFamily: 'Tw Cen MT',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontFamily: 'Tw Cen MT',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blueTextColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 257, child: CustomListView()),
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Stack(
                          children: [
                            Image.asset(
                              AppIcons.meetingImage,
                              fit: BoxFit.fitWidth,
                              height: 80,
                              width: double.infinity,
                            ),
                            Positioned(
                              top: 10,
                              left: 5,
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
                              left: 5,
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
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 15, right: 16),
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
                                      shape: BoxShape.circle,
                                      color: AppColor.greyColor),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
