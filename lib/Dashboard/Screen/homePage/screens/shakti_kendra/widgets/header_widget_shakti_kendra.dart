import 'package:flutter/material.dart';

import '../../../../../../../Values/space_width_widget.dart';
import '../../../../../../../generated/l10n.dart';

Widget headerWidgetShaktiKendra(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(Icons.arrow_back, size: 25),
          )),
      spaceWidthWidget(10),
      Text(
        S.of(context).editShaktiKendr,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      )
    ],
  );
}
