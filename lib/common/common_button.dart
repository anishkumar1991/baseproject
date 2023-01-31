import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.title,
      this.style,
      this.borderRadius,
      this.padding,
      this.margin,
      this.backGroundcolor,
      this.onTap,
      this.isUseWidget = false,
      this.widget,
      this.height,
      this.bordercolor,
      this.width});
  final String? title;
  final TextStyle? style;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final bool? isUseWidget;
  final Widget? widget;
  final Color? backGroundcolor;
  final Color? bordercolor;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        padding: padding,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: bordercolor ?? AppColor.buttonOrangeBackGroundColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            color: backGroundcolor ?? AppColor.buttonOrangeBackGroundColor),
        child: Center(
            child: isUseWidget ?? false
                ? widget
                : Text(
                    title ?? '',
                    style: style,
                  )),
      ),
    );
  }
}
