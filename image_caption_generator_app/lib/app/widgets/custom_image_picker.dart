import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/home_controller.dart';

class CustomImagePicker extends StatelessWidget {
  final homeController = Get.put(HomeController());
  CustomImagePicker({
    super.key,
    this.onPressed,
    required this.color,
    required this.check,
    required this.controller,
    this.isFromGunasho,
    this.text,
  });

  final VoidCallback? onPressed;
  final Color color;
  final String check;
  final File controller;
  final bool? isFromGunasho;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // Full width
          height: 60, // Height of 50
          padding: EdgeInsets.symmetric(horizontal: text != null ? 10.0 : 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),

          child: TextButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              splashFactory: NoSplash.splashFactory,
              shadowColor: Colors.white,
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text != null ? 'Take Photo' : 'Upload'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    text != null
                        ? 'assets/images/camera.png'
                        : 'assets/images/upload.png',
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
