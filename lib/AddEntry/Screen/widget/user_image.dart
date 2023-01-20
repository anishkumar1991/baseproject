import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

class UserImageCard extends StatelessWidget {
  UserImageCard({super.key, this.imageUrl, this.onTap});
  final String? imageUrl;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Image.asset(
            imageUrl ?? '',
            height: 115,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 90,
                padding:
                    const EdgeInsets.only(top: 6, bottom: 6, left: 4, right: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.orange300Color,
                    border: Border.all(
                        color: AppColor.buttonOrangeBackGroundColor)),
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
                      'Update',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColor.buttonOrangeBackGroundColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
