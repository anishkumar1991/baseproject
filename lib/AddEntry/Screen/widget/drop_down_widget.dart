import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../Values/space_width_widget.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {super.key,
      required this.title,
      this.dropDownList,
      this.hintText,
      this.onChange,
      this.validator,
      this.isMandatoryField = false,
      this.selectedValue});
  String title;
  String? hintText;
  Function(dynamic)? onChange;
  dynamic selectedValue;
  FormFieldValidator? validator;
  final bool isMandatoryField;
  List<DropdownMenuItem>? dropDownList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            spaceWidthWidget(5),
            isMandatoryField
                ? const Text(
                    '*',
                    style: TextStyle(color: AppColor.red),
                  )
                : const SizedBox.shrink()
          ],
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
              decoration: const InputDecoration(border: InputBorder.none),
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
