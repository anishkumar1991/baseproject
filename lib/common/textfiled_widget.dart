import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../Values/app_colors.dart';
import 'keyboard_done_button.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      this.controller,
      required this.title,
      this.suffixWidget,
      this.keyboardType,
      this.readOnly,
      this.labelText,
      this.onTap,
      this.maxLines,
      this.onChanged,
      this.inpurborder,
      this.hintText,
      this.preFix,
      this.maxLength,
      this.validator,
      this.errorText,
      this.initialValue,
      this.focus,
      this.onTapDone,
      this.isOtherField = false,
      this.isMandatoryField = false,
      this.textInputFormatter});

  final String? initialValue;

  final TextEditingController? controller;
  final String title;
  final Widget? preFix;
  final TextInputType? keyboardType;
  ValueChanged<String>? onChanged;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final String? hintText;
  final String? labelText;
  final InputBorder? inpurborder;
  final Widget? suffixWidget;
  final int? maxLines;
  final FormFieldValidator? validator;
  final String? errorText;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLength;
  final bool isMandatoryField;
  final focusNode = FocusNode();
  FocusNode? focus;
  bool isOtherField;
  GestureTapCallback? onTapDone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title),
            spaceWidthWidget(5),
            isMandatoryField
                ? const Text(
                    '*',
                    style: TextStyle(color: AppColor.red),
                  )
                : const SizedBox.shrink()
          ],
        ),
        KeyboardActions(
           enable: Platform.isIOS ? true : false,
          autoScroll: false,
          config: KeyboardActionsConfig(actions: [
            KeyboardActionsItem(
                focusNode: isOtherField ? focus! : focusNode,
                displayArrows: false,
                displayActionBar: false,
                footerBuilder: ((context) => CustomKeyBoardDoneButton(
                      onTapDone: isOtherField
                          ? onTapDone
                          : (() {
                              focusNode.unfocus();
                            }),
                    )))
          ]),
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            focusNode: isOtherField ? focus : focusNode,
            maxLength: maxLength,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: textInputFormatter,
            controller: controller,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            decoration: InputDecoration(
                counterText: '',
                border: inpurborder,
                hintText: hintText,
                prefixIcon: preFix,
                labelText: labelText,
                errorText: errorText,
                labelStyle: GoogleFonts.poppins(
                    color: AppColor.naturalBlackColor, fontSize: 14),
                suffixIcon: suffixWidget),
          ),
        ),
      ],
    );
  }
}
