import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';

Widget headerWidgetEditBusiness(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 25,color: AppColor.black,)),
      spaceWidthWidget(10),
      Text(
        S.of(context).business,
        style: textStyleWithPoppin(fontSize: 16,color: AppColor.black,fontWeight: FontWeight.w400),
      )
    ],
  );
}
