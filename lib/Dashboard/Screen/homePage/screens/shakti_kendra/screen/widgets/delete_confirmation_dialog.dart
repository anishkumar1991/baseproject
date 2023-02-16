import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_height_widget.dart';
import '../../../../../../../Values/space_width_widget.dart';
import '../../../../../../../common/appstyle.dart';
import '../../../../../../../common/common_button.dart';
import '../../../../../../../generated/l10n.dart';

dataEntryDeleteDialog(
    {required BuildContext context,
    String? title,
    String? subTitle,
    VoidCallback? onDelete}) async {
  showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title ?? '',
                        textAlign: TextAlign.left,
                        style: textStyleWithPoppin(
                            fontSize: 16,
                            color: AppColor.black.withOpacity(0.9),
                            fontWeight: FontWeight.w400)),
                  ),
                  spaceHeightWidget(10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subTitle ?? '',
                        style: textStyleWithPoppin(
                            fontSize: 14, color: AppColor.greyColor),
                      )),
                  spaceHeightWidget(MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CommonButton(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            bordercolor: AppColor.primaryColor,
                            backGroundcolor: AppColor.white,
                            title: S.of(context).cancel,
                            borderRadius: 10,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.primaryColor)),
                      ),
                      spaceWidthWidget(15),
                      Expanded(
                        child: CommonButton(
                            onTap: onDelete,
                            borderRadius: 10,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            bordercolor: AppColor.red,
                            backGroundcolor: AppColor.red,
                            title: S.of(context).delete,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.white)),
                      ),
                    ],
                  )
                ],
              ),
            ));
      }));
}
