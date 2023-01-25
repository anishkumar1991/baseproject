import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_list/widgets/common_option_button_widget.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_list/widgets/common_pravas_event_button.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/pravas_list/widgets/header_widget_pravas_list.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../../../Values/icons.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/dot_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../route/route_path.dart';
import 'data/fake_list_data.dart';

class PravasListScreen extends StatelessWidget {
  const PravasListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List data = [
      {'text': S.of(context).all, 'color': AppColor.tealColor.withOpacity(0.8)},
      {'text': S.of(context).present, 'color': AppColor.yellowColor},
      {'text': S.of(context).upcoming, 'color': AppColor.pinkColor},
      {'text': S.of(context).Complete, 'color': AppColor.green}
    ];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightWidget(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: headerWidgetPravasList(context),
            ),
            spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CommonOptionButtonWidget(
                          text: data[index]['text'],
                          isSelected: index == 0 ? true : false,
                          color: data[index]['color'],
                        ),
                        spaceWidthWidget(16)
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pravasList.length,
                  itemBuilder: (context, index) {
                    String startMonth =
                        DateFormat.MMM().format(pravasList[index].startDate!);
                    String endMonth =
                        DateFormat.MMM().format(pravasList[index].endDate!);

                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16,right: 2,left: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        color: AppColor.white,
                        boxShadow: [
                        BoxShadow(
                            color: AppColor.greyColor.withOpacity(0.4),
                        blurRadius: 0.1,spreadRadius: 0.5

                      ),
                    ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(AppIcons.calender_1,
                                              height: 20, width: 20),
                                          spaceWidthWidget(10),
                                          Expanded(
                                            child: Text(
                                              '20 - 23 Jan, 2023',
                                              style: textStyleWithPoppin(
                                                  color:
                                                      AppColor.naturalBlackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            ' (${pravasList[index].totalDay})',
                                            style: textStyleWithPoppin(
                                                color: AppColor.naturalBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    spaceHeightWidget(10),
                                    DotWidget(
                                      dashColor: AppColor.naturalBlackColor
                                          .withOpacity(0.1),
                                      dashWidth: 5,
                                      emptyWidth: 2,
                                      totalWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55,
                                    ),
                                    spaceHeightWidget(20),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      child: Text(
                                        '${pravasList[index].title}',
                                        style: textStyleWithPoppin(
                                            color: AppColor.naturalBlackColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 90,
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 25),
                                  child: CircularPercentIndicator(
                                    radius: 28,
                                    progressColor: AppColor.progressGreenColor,
                                    percent: pravasList[index].totalEvent == '-' ? double.parse("0") : (double.parse("${pravasList[index].totalEvent}") / 10),
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${pravasList[index].totalEvent}',
                                          style: textStyleWithPoppin(
                                              color: AppColor.naturalBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          S.of(context).program,
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.naturalBlackColor),
                                        )
                                      ],
                                    ),
                                    backgroundColor:
                                        AppColor.greyColor.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceHeightWidget(10),
                          DotWidget(
                            dashColor:
                                AppColor.naturalBlackColor.withOpacity(0.1),
                            dashWidth: 5,
                            emptyWidth: 2,
                            totalWidth: MediaQuery.of(context).size.width * 0.55,
                          ),
                          spaceHeightWidget(25),
                          CommonPravasEventButton(
                            onTap: () {
                              print("hello");
                              if (pravasList[index]
                                  .endDate!
                                  .isAfter(DateTime.now())) {
                                if (pravasList[index].totalEvent != 0) {
                                  //function create or update
                                  print("0");
                                  Navigator.pushNamed(context,
                                      RoutePath.stayAndProgramListScreen);
                                } else {
                                  print("1");
                                  //function create
                                  Navigator.pushNamed(
                                      context, RoutePath.createFunctionScreen);
                                }
                              } else {
                                //show function
                                print("2");
                                Navigator.pushNamed(
                                    context, RoutePath.stayAndProgramListScreen);
                              }
                            },
                            icon: pravasList[index]
                                    .endDate!
                                    .isAfter(DateTime.now())
                                ? const Icon(Icons.arrow_forward,
                                    color: AppColor.buttonOrangeBackGroundColor)
                                : const Icon(Icons.remove_red_eye_outlined,
                                    color: AppColor.naturalBlackColor),
                            text:
                                pravasList[index].endDate!.isAfter(DateTime.now())
                                    ? pravasList[index].totalEvent != 0
                                        ? S.of(context).createAndUpdateProgram
                                        : S.of(context).makeProgram
                                    : S.of(context).viewProgram,
                            isEnd: pravasList[index]
                                .endDate!
                                .isBefore(DateTime.now()),
                          ),
                          spaceHeightWidget(15),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: CommonButton(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.pravasCreateScreen);
              },
              title: S.of(context).takeATour,
              width: 200,
              height: 50,
              borderRadius: 25,
              // style: const TextStyle(fontSize: 20, color: AppColor.white),
              style: textStyleWithPoppin(color: AppColor.white, fontSize: 16),
            )),
      ),
    );
  }
}
