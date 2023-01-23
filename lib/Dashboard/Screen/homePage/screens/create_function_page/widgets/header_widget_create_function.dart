import 'package:flutter/material.dart';

import '../../../../../../Values/spaceWidthWidget.dart';

Widget headerWidgetCreateFunction(BuildContext context){
  return Row(
    children: [
      InkWell(onTap: () {
        Navigator.pop(context);
      },child: const Icon(Icons.arrow_back,size: 25)),
      spaceWidthWidget(10),
      const Text('कार्याक्रम बनाएँ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)
    ],
  );
}