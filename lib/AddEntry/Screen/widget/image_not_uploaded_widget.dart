import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

class ImageNotUploaded extends StatelessWidget {
  const ImageNotUploaded({super.key, this.onTap});
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppIcons.personLogo,
          height: 68,
        ),
        spaceHeightWidget(8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 98,
            padding:
                const EdgeInsets.only(top: 6, bottom: 6, left: 4, right: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.orange300Color,
                border:
                    Border.all(color: AppColor.buttonOrangeBackGroundColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColor.buttonOrangeBackGroundColor,
                  size: 16,
                ),
                spaceWidthWidget(8),
                Text(
                  'Add photo',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.buttonOrangeBackGroundColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
