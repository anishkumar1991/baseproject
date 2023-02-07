import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

class UploadCard extends StatelessWidget {
  const UploadCard(
      {super.key,
      required this.onTap,
      this.uploadedFilePath,
      this.onTapImagePrivew});

  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapImagePrivew;

  final String? uploadedFilePath;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Flexible(
        //     child: Text(
        //   uploadedFilePath ?? '',
        // )),
        uploadedFilePath?.isNotEmpty ?? false
            ? InkWell(
                onTap: onTapImagePrivew,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greenshade900),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppIcons.galleryColorImage,
                        height: 15,
                        color: AppColor.greenshade900,
                      ),
                      spaceWidthWidget(5),
                      Text(
                        'File uploaded',
                        style: TextStyle(
                            color: AppColor.greenshade900, fontSize: 12),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        spaceHeightWidget(8),
        CommonButton(
          onTap: onTap,
          width: 105,
          padding: const EdgeInsets.all(5),
          borderRadius: 5,
          isUseWidget: true,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.ios_share_outlined,
                color: AppColor.white,
                size: 18,
              ),
              spaceWidthWidget(4),
              Text(
                'Upload File',
                style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: AppColor.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
