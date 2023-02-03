import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      maxLength: 10,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
          errorStyle: const TextStyle(color: Colors.red),
          hintText: '000-000-00-00',
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
