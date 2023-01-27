import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {super.key,
      required this.title,
      this.dropDownList,
      this.hintText,
      this.onChange,
      this.selectedValue});
  String title;
  String? hintText;
  Function(dynamic)? onChange;
  dynamic selectedValue;
  List<DropdownMenuItem>? dropDownList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton(
              icon: const Icon(
                Icons.expand_more,
                color: AppColor.textBlackColor,
              ),
              isExpanded: true,
              value: selectedValue,
              hint: Text(
                hintText ?? "",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColor.greyColor),
              ),
              items: dropDownList,
              onChanged: ((value) => onChange!(value))),
        ),
        const Divider(
          height: 2,
          thickness: 1.5,
          color: AppColor.textBlackColor,
        )
      ],
    );
  }
}
