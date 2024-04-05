import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    required this.text,
    this.isPadding,
  });

  final String text;
  final bool? isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isPadding == false ? 0 : 8,
      ),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.red,
          fontSize: Adaptive.sp(15),
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
