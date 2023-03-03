import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Values/app_colors.dart';

class CardContent extends StatefulWidget {
  final String id;
  final String date;
  final String time;
  final String img;
  final String clickNreport;

  const CardContent(
      {required String this.id,
      super.key,
      required this.date,
      required this.time,
      required this.img,
      required this.clickNreport});

  @override
  State<CardContent> createState() => _CardContentState(
      id: this.id,
      date: this.date,
      time: this.time,
      img: this.img,
      clickNreport: this.clickNreport);
}

class _CardContentState extends State<CardContent> {
  final String id;
  final String date;
  final String time;
  final String img;
  final String clickNreport;

  _CardContentState({
    required this.id,
    required this.date,
    required this.time,
    required this.img,
    required this.clickNreport,
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
          top: -38,
          left: 0,
          bottom: 0,
          right: 0,
          child: Stack(children: [
            Image.asset(
              'assets/images/DashMKB3Edit.jpg',
              width: MediaQuery.of(context).size.width,
              height: 400,
            ),
          ]),
        ),
        Positioned.fill(
          top: 0,
          bottom: 0,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 11, left: 20, right: 1, bottom: 11),
                    child: Column(
                      children: [
                        Flexible(
                          child: Column(
                            children: [

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  // ('${state.dashModal.data?.first.id}th Mann ki Baat'),
                                  '${id}',
                                  style: GoogleFonts.publicSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),

                              SizedBox(
                                height: 60,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Aired on-',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColor()
                                                  .dashboardTextColorLight),
                                        ),
                                        Text(
                                          // ' ${state.dashModal.data?.first.airedDetail?.date}',
                                          '$date',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color:
                                              AppColor()
                                                  .dashboardTextColorDark),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      //' ${state.dashModal.data?.first.airedDetail?.time}',
                                      '$time',
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColor()
                                              .dashboardTextColorLight),
                                    )
                                  ],
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child:,
                              // ),

                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: ,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${clickNreport} >',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 14, right: 16,bottom: 16),
                    child: Card(
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
        )
      ],
    );
  }
}
