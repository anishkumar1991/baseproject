import 'package:flutter/material.dart';

import '../../../../Values/app_colors.dart';
import 'CardContent.dart';

class ProgramCard extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String img;
  final String clickNreport;
  final String airedText;
  final String reportText;
  final Function() onPressAddEvent;
  final String addMoreReport;
  final Function() onPressAddMoreEvent;



  ProgramCard({required String this.id,
    Key? key,
    required this.date,
    required this.time,
    required this.img,
    required this.clickNreport, required this.airedText, required this.onPressAddEvent, required this.reportText, required this.addMoreReport, required this.onPressAddMoreEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      shadowColor: AppColor().cardBGcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: SizedBox(
        height: 200,
        child: CardContent(
          id: id,
          date: date,
          time: time,
          img: img,
          clickNreport: clickNreport,
          airText: airedText,
          onPressAddEvent: onPressAddEvent,
          reportText:reportText,
          onPressAddMoreEvent: onPressAddMoreEvent,
          addMoreReport: addMoreReport,

        ),
      ),
    );
  }
}
