import 'package:flutter/material.dart';

import '../../../../../../../Values/app_colors.dart';
import '../../../../../../../Values/space_width_widget.dart';
import '../../../../../../../common/appstyle.dart';


class BuildButton extends StatelessWidget {
  String? text;
  IconData? icon;
  double? width;
  GestureTapCallback? onTap;
   BuildButton({Key? key,this.text,this.icon,this.width,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? '',
              style: textStyleWithPoppin(color: AppColor.black,fontSize: 14),

            ),
            spaceWidthWidget(8),
            Icon(icon,color: AppColor.greyColor,size: 22,)
          ],
        ),
      ),
    );
  }
}
