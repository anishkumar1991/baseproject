import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void share(BuildContext context, String url) {
  String _url = url;
  final text =
      "Gujarat's unbreakable bond with BJP \n\n https://youtu.be/$_url";
  final box = context.findRenderObject() as RenderBox?;
  Share.share(text,
      subject: 'Testing',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
