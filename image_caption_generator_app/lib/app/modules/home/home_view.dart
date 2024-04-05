import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_caption_generator/app/modules/home/home_controller.dart';
import 'package:image_caption_generator/app/widgets/custom_elevated_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/colors.dart';
import '../../widgets/custom_error.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/ovelayed_loading_screen.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,
              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 20.h,
                    ),
                  ),
                  const Text(
                    'Captioner',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Adaptive.w(42),
                        child: CustomImagePicker(
                          color: Colors.black,
                          onPressed: () async {
                            // pick image
                            await homeController.captureImage();
                            homeController.customValidations();
                          },
                          text: "Take Picture",
                          check:
                              homeController.pickedImage.value.path.toString(),
                          controller: homeController.pickedImage.value,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: Adaptive.w(42),
                        child: CustomImagePicker(
                          color: Colors.black,
                          onPressed: () async {
                            // pick image
                            await homeController.pickPhotos();
                            homeController.customValidations();
                          },
                          check:
                              homeController.pickedImage.value.path.toString(),
                          controller: homeController.pickedImage.value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Obx(
                      () => homeController.pickedImage.value.path.toString() ==
                              'empty'
                          ? SizedBox(
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Image.asset(
                                  'assets/images/image.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Image.file(
                              homeController.pickedImage.value,
                            ),
                    ),
                  ),
                  Obx(
                    () => homeController.isImageError.value
                        ? CustomError(
                            text: 'Please upload a photo'.tr,
                          )
                        : const SizedBox(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      homeController.onSubmit();
                    },
                    text: "Generate Caption",
                    width: double.infinity,
                    height: 6.h,
                    borderRadius: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => homeController.isUploadImageLoading.value
              ? Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  body: OverlayedLoadingScreen(
                    child: Text(
                      'Generating Caption...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
