import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';

import '../../../../generated/l10n.dart';

class PravasCardWidget extends StatelessWidget {
  const PravasCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.pravasCradColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.pravasCradColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).tour,
                      style: const TextStyle(
                          fontFamily: 'Tw Cen MT',
                          color: AppColor.textBlackColor,
                          fontSize: 20),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (() {
                        Navigator.pushNamed(
                            context, RoutePath.pravasListScreen);
                      }),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColor.iconBackGroudColor,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.chevron_right),
                      ),
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
                      color: AppColor.buttonTextColor),
                  child: IntrinsicHeight(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(AppIcons.checkBox,
                                        height: 20, width: 20),
                                    spaceWidthWidget(10),
                                    Text(
                                      S.of(context).totalTravelSoFar,
                                      style: const TextStyle(
                                          fontFamily: 'Tw Cen MT',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.naturalBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text('10',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.blue)),
                              ),
                            ],
                          ),
                          const Divider(
                            indent: 6,
                            endIndent: 6,
                            color: AppColor.borderColor,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(AppIcons.calender,
                                        height: 20, width: 20),
                                    spaceWidthWidget(10),
                                    Text(
                                      S.of(context).upcomingTrip,
                                      style: const TextStyle(
                                          fontFamily: 'Tw Cen MT',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.naturalBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text('06',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.blue)),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          // isOpen
          //     ? ListView.separated(
          //         shrinkWrap: true,
          //         itemCount: 3,
          //         separatorBuilder: ((context, index) => Divider(
          //               color: AppColor.greyColor.withOpacity(0.3),
          //             )),
          //         itemBuilder: ((context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 14),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   '${index + 1}. PM’s visit to Meghalaya & Tripura',
          //                   style: const TextStyle(
          //                       fontSize: 16, fontFamily: 'Tw Cen MT'),
          //                 ),
          //                 const Icon(Icons.chevron_right)
          //               ],
          //             ),
          //           );
          //         }))
          //     : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
