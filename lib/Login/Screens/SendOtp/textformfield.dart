import 'package:flutter/material.dart';
import '../../../Values/app_colors.dart';

class TextFormFieldLogin extends StatelessWidget {
  const TextFormFieldLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: AppColor().textColor),
        maxLength: 10,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColor().textFieldColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(width: 1, color: AppColor().textFieldColor))),
        keyboardType: TextInputType.number,
        onChanged: (value) {});
  }
}
