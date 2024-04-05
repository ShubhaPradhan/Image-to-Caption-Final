import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../config/colors.dart';

class OverlayedLoadingScreen extends StatelessWidget {
  const OverlayedLoadingScreen({
    super.key,
    this.color,
    this.child,
  });

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    debugPrint(color.toString());
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: const Color.fromARGB(102, 0, 0, 0).withOpacity(0.6),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitPulse(
                color: color ?? Colors.white,
                size: 40.sp,
              ),
              SizedBox(height: 3.h),
              child ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
