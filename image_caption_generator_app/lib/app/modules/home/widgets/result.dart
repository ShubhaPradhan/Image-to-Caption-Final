import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_caption_generator/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../home_controller.dart';
import 'image_viewer.dart';

class Result extends StatelessWidget {
  final homeController = Get.put(HomeController());
  Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // make back button white
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ImageViewerPage(
                          imageViewUrl: homeController
                              .captionGenerationResponseApi.value.imageUrl!,
                        ),
                        transition: Transition.zoom,
                      );
                    },
                    child: Image.network(
                      homeController
                          .captionGenerationResponseApi.value.imageUrl!,
                      height: 40.h,
                      width: 100.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Generated Caption',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  child: Text(
                    '"${homeController.captionGenerationResponseApi.value.caption}"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Attention Map',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ImageViewerPage(
                          imageViewUrl: homeController
                              .captionGenerationResponseApi
                              .value
                              .attentionImageUrl!),
                      transition: Transition.zoom,
                    );
                  },
                  child: Image.network(
                    homeController
                        .captionGenerationResponseApi.value.attentionImageUrl!,
                    height: 40.h,
                    width: 100.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
