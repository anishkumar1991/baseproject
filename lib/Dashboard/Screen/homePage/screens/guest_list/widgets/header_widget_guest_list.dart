import 'package:flutter/material.dart';

import '../../../../../../Values/space_width_widget.dart';


Widget headerWidgetGuestList(BuildContext context){
  return Row(
    children: [
      InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,size: 25)),
      spaceWidthWidget(10),
      const Text('उपस्थित अतिथि / प्रतिभागी / कार्यकर्ता',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
    ],
  );
}