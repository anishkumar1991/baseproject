import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../Values/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
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
  FocusNode? focus;
  bool isOtherField;
  GestureTapCallback? onTapDone;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(actions: [
      KeyboardActionsItem(focusNode: _nodeText1, toolbarButtons: [
        (node) {
          return GestureDetector(
            onTap: () => node.unfocus(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Done",
              ),
            ),
          );
        }
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.title),
            spaceWidthWidget(5),
            widget.isMandatoryField
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
          config: _buildConfig(context),
          child: TextFormField(
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            focusNode: _nodeText1,
            maxLength: widget.maxLength,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: widget.textInputFormatter,
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            decoration: InputDecoration(
                counterText: '',
                border: widget.inpurborder,
                hintText: widget.hintText,
                prefixIcon: widget.preFix,
                labelText: widget.labelText,
                errorText: widget.errorText,
                labelStyle: GoogleFonts.poppins(color: AppColor.naturalBlackColor, fontSize: 14),
                suffixIcon: widget.suffixWidget),
          ),
        ),
      ],
    );
  }
}
