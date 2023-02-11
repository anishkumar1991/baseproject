import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../generated/l10n.dart';

class PannaNoListBottomSheetWidget extends StatefulWidget {
  const PannaNoListBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<PannaNoListBottomSheetWidget> createState() =>
      _PannaNoListBottomSheetWidgetState();
}

class _PannaNoListBottomSheetWidgetState
    extends State<PannaNoListBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(S.of(context).pannaKramaank,
              style: GoogleFonts.poppins(
                color: AppColor.borderColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
          const Divider(
            color: AppColor.borderColor,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return listTilePanna(index: index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listTilePanna({required int index}) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColor.dividerColor,
              ),
              child: Text("${index + 1}",
                  style: GoogleFonts.poppins(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  )),
            ),
            const SizedBox(
              width: 100,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("पन्ना प्रमुख",
                      style: GoogleFonts.poppins(
                        color: AppColor.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      )),
                  Text("अनिरुद्ध पुरोहित",
                      style: GoogleFonts.poppins(
                        color: AppColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ))
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
