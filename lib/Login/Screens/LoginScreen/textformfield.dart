import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../Values/app_colors.dart';
import '../../../generated/l10n.dart';

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
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.left,

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
        if (value?.isEmpty ?? false) {
          return S.of(context).enterMobileNumber;
        } else if (value?.length != 10) {
          return S.of(context).enterPhoneNumber;
        } else if (RegExp(r'0000000000').hasMatch(value!)) {
          return S.of(context).notValidNumber;
        }
      }),
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          counterText: '',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    '+91',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          prefixIconConstraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.15),
          errorStyle: const TextStyle(color: AppColor.redColor),
          hintText: '000-000-00-00',
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
