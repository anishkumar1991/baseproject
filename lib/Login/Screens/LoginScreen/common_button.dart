import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

class CommonButton extends StatelessWidget {
  CommonButton(
      {super.key,
      this.title,
      this.style,
      this.borderRadius,
      this.padding,
      this.margin,
      this.onTap,
      this.isUseWidget = false,
      this.widget,
      this.width});
  final String? title;
  final TextStyle? style;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final bool? isUseWidget;
  final Widget? widget;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            color: AppColor.buttonOrangeBackGroundColor),
        child: Center(
            child:isUseWidget??false?widget: Text(
          title ?? '',
          style: style,
        )),
      ),
    );
  }
}
