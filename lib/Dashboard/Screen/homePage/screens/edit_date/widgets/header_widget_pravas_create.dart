import 'package:flutter/material.dart';

import '../../../../../../Values/space_width_widget.dart';

Widget headerWidgetEditDate(){
  return Row(
    children: [
      const Icon(Icons.arrow_back,size: 25),
      spaceWidthWidget(10),
      const Text('दिनांक और समय एडिट करें',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
    ],
  );
}