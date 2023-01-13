import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

class CommonButton extends StatelessWidget {
  CommonButton({super.key, this.title,this.style});
  final String? title;
    final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.buttonOrangeBackGroundColor),
      child: Center(child: Text(title ?? '',style: style,)),
    );
  }
}
