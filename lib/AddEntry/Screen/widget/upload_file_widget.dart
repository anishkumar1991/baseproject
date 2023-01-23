import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/common/textfiled_widget.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

import '../../../common/common_button.dart';

class UploadCard extends StatelessWidget {
  UploadCard({super.key, required this.onTap, this.uploadedFilePath});

  final GestureTapCallback? onTap;
  final String? uploadedFilePath;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(
          uploadedFilePath ?? '',
        )),
        spaceHeightWidget(8),
        CommonButton(
          onTap: onTap,
          width: 100,
          padding: const EdgeInsets.all(5),
          borderRadius: 5,
          isUseWidget: true,
          widget: Row(
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
