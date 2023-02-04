import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sangathan/Values/app_colors.dart';

class CustomOtpTextField extends StatefulWidget {
  CustomOtpTextField(
      {Key? key,
      required this.controller,
      required this.otpText,
      required this.onComplete,
      required this.onChange,
      this.fieldWidth})
      : super(key: key);
  TextEditingController controller;
  String otpText;
  double? fieldWidth;
  Function(String) onChange;
    Function(String) onComplete;


  @override
  State<CustomOtpTextField> createState() => _CustomOtpTextFieldState();
}

class _CustomOtpTextFieldState extends State<CustomOtpTextField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      keyboardType: TextInputType.number,
      appContext: context,
      cursorColor: AppColor.orange,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 45,
        fieldWidth: widget.fieldWidth ?? 45,
        selectedFillColor: AppColor.greyWithOpacity01,
        activeFillColor: AppColor.greyWithOpacity01,
        inactiveFillColor: AppColor.greyWithOpacity01,
        activeColor: AppColor.greyColor.withOpacity(0.3),
        borderWidth: 1,
        selectedColor: AppColor.greyColor.withOpacity(0.3),
        inactiveColor: AppColor.greyColor.withOpacity(0.3),
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: widget.controller,
      onCompleted:((v) => widget.onComplete(v)),
      onChanged: ((value) => widget.onChange(value)),
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return false;
      },
    );
  }
}
