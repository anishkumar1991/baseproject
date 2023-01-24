import 'package:flutter/material.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../../../../Values/app_colors.dart';

class CommonPravasEventButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool? isEnd;
  final GestureTapCallback? onTap;

  const CommonPravasEventButton(
      {required this.text, required this.icon, this.isEnd,this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isEnd ?? false
                    ? AppColor.naturalBlackColor.withOpacity(0.3)
                    : AppColor.buttonOrangeBackGroundColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 16,
                    color: isEnd ?? false
                        ? AppColor.naturalBlackColor
                        : AppColor.buttonOrangeBackGroundColor)),
            spaceWidthWidget(20),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: icon,
            )
          ],
        ),
      ),
    );
  }
}
