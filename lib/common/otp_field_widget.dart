import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sangathan/Values/app_colors.dart';

class CustomOtpTextField extends StatefulWidget {
  CustomOtpTextField({
    Key? key,
    required this.controller,
    required this.onComplete,
    required this.onChange,
    this.shape,
    this.activeColor,
    this.activeFillColor,
    this.fieldWidth,
    this.inactiveFillColor,
    this.selectedFillColor,
  }) : super(key: key);
  final TextEditingController controller;
  double? fieldWidth;
  Function(String) onChange;
  Function(String) onComplete;
  PinCodeFieldShape? shape;
  Color? selectedFillColor;
  Color? activeFillColor;
  Color? inactiveFillColor;
  Color? activeColor;

  @override
  State<CustomOtpTextField> createState() => _CustomOtpTextFieldState();
}

class _CustomOtpTextFieldState extends State<CustomOtpTextField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDisposeControllers: false,
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
        shape: widget.shape ?? PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 45,
        fieldWidth: widget.fieldWidth ?? 45,
        selectedFillColor:
            widget.selectedFillColor ?? AppColor.greyWithOpacity01,
        activeFillColor: widget.activeFillColor ?? AppColor.greyWithOpacity01,
        inactiveFillColor:
            widget.inactiveFillColor ?? AppColor.greyWithOpacity01,
        activeColor: widget.activeColor ?? AppColor.greyColor.withOpacity(0.3),
        borderWidth: 1,
        selectedColor: AppColor.greyColor.withOpacity(0.3),
        inactiveColor: AppColor.greyColor.withOpacity(0.3),
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: widget.controller,
      onCompleted: ((v) => widget.onComplete(v)),
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
