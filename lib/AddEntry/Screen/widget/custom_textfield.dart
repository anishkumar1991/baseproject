import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../Values/space_width_widget.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool? obSecureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? validator;
  final Color? borderColor;
  final int? maxLines;
  final Widget? prefixWidget;
  final EdgeInsets? contentPadding;
  final Widget? suffixWidget;
  final bool isMandatoryField;
  const CommonTextField(
      {this.title,
      this.hintText,
      this.obSecureText,
      this.keyboardType,
      this.controller,
      this.inputFormatters,
      this.validator,
      this.borderColor,
      this.maxLines,
      this.prefixWidget,
      this.contentPadding,
      this.suffixWidget,
      this.isMandatoryField = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 6,
          left: 9,
        ),
        height: maxLines == null ? 66 : 90,
        decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid,
                color: borderColor ?? AppColor.greyColor.withOpacity(0.2),
                width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(title ?? '',
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textBlackColor.withOpacity(0.6))),
                  spaceWidthWidget(5),
                  isMandatoryField
                      ? const Text(
                          '*',
                          style: TextStyle(color: AppColor.red),
                        )
                      : const SizedBox.shrink()
                ],
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    return validator == null
                        ? null
                        : validator!(value.toString());
                  },
                  controller: controller,
                  maxLines: maxLines ?? 1,
                  cursorColor: borderColor ?? AppColor.textBlackColor,
                  obscureText: obSecureText ?? false,
                  keyboardType: keyboardType ?? TextInputType.text,
                  style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBlackColor),
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    prefixIcon: prefixWidget,
                    suffixIcon: suffixWidget,
                    errorStyle: const TextStyle(color: AppColor.redColor),
                    contentPadding: contentPadding,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hintText ?? '',
                    hintStyle: TextStyle(
                        color: AppColor.greyColor.withOpacity(0.4),
                        fontSize: 15),
                  ),
                ),
              ),
            ]));
  }
}
