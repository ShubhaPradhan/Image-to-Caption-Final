import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../config/colors.dart';

import '../modules/home/home_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../services/storage/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storageController = Get.put(StorageService());

  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      // Uncomment to enable language feature

      storageController.isNewUser()
          ? Get.offAll(() => OnBoardingView())
          : Get.offAll(() => HomeView());
    });
  }

  //---------------Load Home page data---------------//
  void loadData(var accessToken) async {}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              // color: Colors.transparent,
            ),
            SizedBox(
              height: 5.h,
            ),
            const SpinKitCircle(
              color: primaryColor,
            ),
          ],
        )),
      ),
    );
  }
}
