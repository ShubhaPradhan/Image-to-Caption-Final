import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_caption_generator/app/modules/home/home_view.dart';
import 'package:image_caption_generator/app/modules/onboarding/onboarding_controller.dart';
import 'package:image_caption_generator/app/modules/onboarding/widgets/tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/colors.dart';
import '../../services/storage/services.dart';

class OnBoardingView extends StatelessWidget {
  final onboardingController = Get.put(OnBoardingController());
  final storageController = Get.put(StorageService());

  OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            child: Stack(
              children: [
                PageView(
                  controller: onboardingController.controller,
                  onPageChanged: (value) {
                    onboardingController.onLastPage.value = value == 2;
                  },
                  children: const [
                    Tile(
                      image: "assets/images/onboarding1.png",
                      title: "Caption It",
                      subtitles: "Your one stop solution for image captioning",
                    ),
                    Tile(
                      image: "assets/images/onboarding1.png",
                      title: "Upload",
                      subtitles: "Upload an image from your gallery",
                    ),
                    Tile(
                      image: "assets/images/onboarding1.png",
                      title: "Generate",
                      subtitles: "Generate a caption for your image",
                    ),
                  ],
                ),
                Container(
                    alignment: const Alignment(0, 0.75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: onboardingController.onLastPage.value
                              ? null
                              : () {
                                  onboardingController.controller.jumpToPage(2);
                                },
                          child: const Text(
                            'Skip',
                            style: TextStyle(),
                          ),
                        ),
                        SmoothPageIndicator(
                            effect: ExpandingDotsEffect(
                                dotHeight: 1.h,
                                dotWidth: 2.w,
                                activeDotColor: primaryColor,
                                dotColor: Colors.grey),
                            controller: onboardingController.controller,
                            count: 3),
                        TextButton(
                            onPressed: () {
                              storageController.clickedGetStarted();
                              if (onboardingController.onLastPage.value) {
                                Get.offAll(() => HomeView());
                              } else {
                                onboardingController.controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic);
                              }
                            },
                            child: Text(
                              onboardingController.onLastPage.value
                                  ? 'Let\'s go'
                                  : 'Next',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
