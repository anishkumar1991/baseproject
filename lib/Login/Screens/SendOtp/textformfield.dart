import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Values/app_colors.dart';

class TextFormFieldLogin extends StatelessWidget {
  TextFormFieldLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefix: Text('+91',style: GoogleFonts.poppins(
          color: AppColor.textGreyColor,
          fontSize: 16
        ),),
          errorStyle: const TextStyle(color: Colors.red),
          hintText: ' 000-000-000-0',
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
