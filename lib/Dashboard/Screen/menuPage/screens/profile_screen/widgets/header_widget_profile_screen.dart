import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';

Widget headerWidgetProfileScreen(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: () {
            EasyLoading.dismiss();
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              size: 25,
              color: AppColor.white,
            ),
          )),
      spaceWidthWidget(10),
      Text(
        S.of(context).profile,
        style: textStyleWithPoppin(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w400),
      )
    ],
  );
}
