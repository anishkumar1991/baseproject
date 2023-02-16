import 'package:flutter/material.dart';

import '../../../../../../../Values/app_colors.dart';


class CommonOptionButtonWidget extends StatelessWidget {
  final String text;
  final bool? isSelected;
  final Color color;

  const CommonOptionButtonWidget(
      {required this.text, this.isSelected,required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: color),
      child: Text(text,
          style: TextStyle(
              fontSize: 16,
              color: isSelected ?? false ? AppColor.white : AppColor.black)),
    );
  }
}
