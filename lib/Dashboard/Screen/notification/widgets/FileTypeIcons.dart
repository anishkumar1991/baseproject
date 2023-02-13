import 'package:flutter/material.dart';

class CustomFileIcon extends StatelessWidget {
  final String? FileType;

  const CustomFileIcon({Key? key, required this.FileType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FileType == "PDF" || FileType == "pdf") {
      return Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
            color: Color(0xFFFFD2B3),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Image.asset("assets/images/notificationPdfIcon.png"),
        ),
      );
    } else if (FileType == "Image" || FileType == "image") {
      return Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
            color: Color(0xFF99DAFF),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(6.5),
          child: Image.asset("assets/images/notificationImageIcon.png"),
        ),
      );
    } else if (FileType == "Link" || FileType == "link") {
      return Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
            color: Color(0xFFFFAECB),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(6.5),
          child: Image.asset("assets/images/notificationLinkIcon.png"),
        ),
      );
    } else {
      return Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(6.5),
          child: Image.asset("assets/images/notificationImageIcon.png"),
        ),
      );
    }
  }
}
