import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/AddEntry/Screen/widget/textfiled_widget.dart';
import 'package:sangathan/Login/Screens/LoginScreen/common_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

class UploadCard extends StatelessWidget {
  UploadCard(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.title});
  final String title;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFieldWidget(
            controller: controller,
            title: title,
            keyboardType: TextInputType.number,
            hintText: hintText),
        spaceHeightWidget(8),
        CommonButton(
          width: 100,
          padding: const EdgeInsets.all(5),
          borderRadius: 5,
          isUseWidget: true,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
