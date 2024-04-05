import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../config/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final Color? fontColor;
  final double? fontSize;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final Alignment? alignment;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.borderColor,
    this.fontColor,
    this.fontSize,
    this.bgColor,
    this.fontWeight,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.transparent,
        minimumSize: Size(width, height),
        backgroundColor:
            bgColor ?? primaryColor, // Customize the button padding
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            10.0,
          ), // Customize the button border radius
        ), // Set the button's background color to transparent
        splashFactory: NoSplash.splashFactory,
        shadowColor: Colors.transparent,
      ),
      child: Align(
        alignment: alignment ?? Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: fontColor ?? Colors.white, // Customize text color
              fontSize: fontSize ?? 16.0.sp,
              fontWeight: fontWeight ?? FontWeight.normal // Customize text size
              ),
        ),
      ),
    );
  }
}
