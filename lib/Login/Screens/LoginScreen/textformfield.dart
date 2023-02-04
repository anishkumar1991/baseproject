import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../Values/app_colors.dart';

class TextFormFieldLogin extends StatelessWidget {
  TextFormFieldLogin({Key? key, required this.controller})
      : super(
          key: key,
        );
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '*#########',
            filter: {"*": RegExp(r'^[5-9]'), "#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ],
      maxLength: 10,
      validator: ((value) {
        // if (!RegExp('[a-zA-Z0-9&%=]+').hasMatch(value!)) {
        //   return 'Please Enter Valid Number';
        // }
        if (value?.isEmpty ?? false) {
          return 'Please Enter Mobile Number';
        } else if (value?.length != 10) {
          return 'Mobile number should be 10 digit';
        } else if (RegExp(r'0000000000').hasMatch(value!)) {
          return 'This Number is Not Valid Number';
        }
      }),
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          counterText: '',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '+91',
              style: GoogleFonts.poppins(
                  color: AppColor.textGreyColor, fontSize: 16),
            ),
          ),
          errorStyle: const TextStyle(color: AppColor.redColor),
          hintText: '000-000-00-00',
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
