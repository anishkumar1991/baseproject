import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/app_colors.dart';
import 'AddEventButtons/AddEventButton.dart';

class CardContent extends StatefulWidget {
  final String id;
  final String date;
  final String time;
  final String img;
  final String clickNreport;
  final String airText;
  final String reportText;
  final Function() onPressAddEvent;
  final String addMoreReport;
  final Function() onPressAddMoreEvent;

  const CardContent({
    required String this.id,
    super.key,
    required this.date,
    required this.time,
    required this.img,
    required this.clickNreport,
    required this.airText,
    required this.onPressAddEvent,
    required this.reportText,
    required this.onPressAddMoreEvent,
    required this.addMoreReport,
  });

  @override
  State<CardContent> createState() => _CardContentState(
        id: this.id,
        date: this.date,
        time: this.time,
        img: this.img,
        clickNreport: this.clickNreport,
        onPressAddEvent: this.onPressAddEvent,
        onPressAddMoreEvent: this.onPressAddMoreEvent,
      );
}

class _CardContentState extends State<CardContent> {
  final String id;
  final String date;
  final String time;
  final String img;
  final String clickNreport;
  final Function() onPressAddEvent;
  final Function() onPressAddMoreEvent;

  _CardContentState({
    required this.id,
    required this.date,
    required this.time,
    required this.img,
    required this.clickNreport,
    required this.onPressAddEvent,
    required this.onPressAddMoreEvent,
  });

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     final contentCubit = context.read<DashCubit>().getDashData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //final cubit = context.read<DashCubit>();
    return Stack(
      children: [
        Positioned(
          top: -2,
          left: -3,
          right: -8,
          child: Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/DashMKB3Edit.jpg',
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: -38,
        //   left: 0,
        //   bottom: 0,
        //   right: 0,
        //   child: Container(
        //     child: Image.asset(
        //       'assets/images/DashMKB3Edit.jpg',
        //       width: MediaQuery.of(context).size.width,
        //       height: 400,
        //     ),
        //   ),
        // ),
        Positioned.fill(
          top: 0,
          bottom: 0,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 11, left: 20, right: 1, bottom: 0),
                    child: Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 70,
                                child: Text(
                                  id,
                                  style: GoogleFonts.publicSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child:  SizedBox(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 14, right: 16, bottom: 30),
                    child: img==""? const SizedBox() : Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shadowColor: AppColor().cardBGcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                img,
                                //extensions like .jpg, .png etc
                                errorBuilder: (context, error, stackTrace) =>
                                    SvgPicture.network(
                                  img, // for .svg extension
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.airText,
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor()
                            .dashboardTextColorLight),
                  ),
                  Text(
                    // ' ${state.dashModal.data?.first.airedDetail?.date}',
                    date,
                    style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColor()
                            .dashboardTextColorDark),
                  ),
                ],
              ),
              const SizedBox(
                width: 17,
              ),
              Text(
                //' ${state.dashModal.data?.first.airedDetail?.time}',
                '$time',
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color:
                    AppColor().dashboardTextColorLight),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 6,
          left: 10,
          child: AddEventButton(
            onPressAddEvent: onPressAddEvent,
            textButtonText: widget.reportText,
          ),
        ),
        Positioned(
            bottom: 6,
            right: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: AddEventButton(
                onPressAddEvent: onPressAddMoreEvent,
                textButtonText: widget.addMoreReport,
              ),
            ))
      ],
    );
  }
}
