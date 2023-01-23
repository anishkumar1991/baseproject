import 'package:flutter/material.dart';

import '../../../../../../Values/spaceWidthWidget.dart';

Widget headerWidgetPravasCreate(){
  return Row(
    children: [
      const Icon(Icons.arrow_back,size: 25),
      spaceWidthWidget(10),
      const Text('प्रवास बनाएँ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
    ],
  );
}