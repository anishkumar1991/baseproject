import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreViewDialog extends StatelessWidget {
  const ImagePreViewDialog({Key? key,required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.close)),
      ),
      content: Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(
                      File(path))))),
    );
  }
}
