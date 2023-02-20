import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/string_utils.dart';

class CommonLogoWidget extends StatefulWidget {
  final String name;
  final bool isSelected;

  const CommonLogoWidget(
      {Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  State<CommonLogoWidget> createState() => _CommonLogoWidgetState();
}

class _CommonLogoWidgetState extends State<CommonLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 11.5),
          child: Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: widget.isSelected
                  ? AppColor.orange
                  : AppColor.naturalBlackColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    StringUtils.logoTitleCase(widget.name),
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Positioned(
            top: 10,
            child: Icon(
              Icons.location_on_sharp,
              size: 25,
            ))
      ],
    );
  }
}
