import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/AppColors.dart';

class CardContent extends StatefulWidget {
  final String id;
  final String date;
  final String time;
  final String img;

  const CardContent(
      {required String this.id,
      super.key,
      required this.date,
      required this.time,
      required this.img});

  @override
  State<CardContent> createState() => _CardContentState(
      id: this.id, date: this.date, time: this.time, img: this.img);
}

class _CardContentState extends State<CardContent> {
  final String id;
  final String date;
  final String time;
  final String img;

  _CardContentState({
    required this.id,
    required this.date,
    required this.time,
    required this.img,
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
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 11, left: 9, right: 1, bottom: 11),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            // ('${state.dashModal.data?.first.id}th Mann ki Baat'),
                            '${id}th Mann ki Baat',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColor().buttonColor),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Aired on-',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                                color: AppColor().dashboardTextColorLight),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            // ' ${state.dashModal.data?.first.airedDetail?.date}',
                            '$date',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: AppColor().dashboardTextColorDark),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            //' ${state.dashModal.data?.first.airedDetail?.time}',
                            '$time',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                                color: AppColor().dashboardTextColorLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Click here to know more >',
                      style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Center(
                child: Image.network(
                  img,
                  //extensions like .jpg, .png etc
                  errorBuilder: (context, error, stackTrace) =>
                      SvgPicture.network(
                    img, // for .svg extension
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
