import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitles,
  });

  final String image;
  final String title;
  final String subtitles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 100.w,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.w),
                child: Text(
                  subtitles,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
