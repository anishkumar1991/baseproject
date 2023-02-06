import 'package:flutter/material.dart';

import '../../../../../../../Values/space_width_widget.dart';
import '../../../../../../../generated/l10n.dart';

Widget headerWidgetEditShaktiKendra(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 25)),
      spaceWidthWidget(10),
      Text(
        S.of(context).shaktiKendraCreation,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      )
    ],
  );
}
