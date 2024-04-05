import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_caption_generator/app/modules/home/widgets/result.dart';
import 'package:image_caption_generator/app/services/api_client.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/caption_generation_repository.dart';
import '../../data/caption_generation_response.dart';

class HomeController extends GetxController {
  final pickedImage = File('empty').obs;
  final picker = ImagePicker();
  final isImageError = false.obs;
  final isUploadImageLoading = false.obs;

  final captionGenerationResponseApi = CaptionGenerationResponse().obs;
  final captionGenerationRepo = CaptionGenerationRepository();

  Future pickPhotos() async {
    final pickedImg = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImg != null) {
      pickedImage.value = File(pickedImg.path);
    }
  }

  // camera image picker
  Future captureImage() async {
    final pickedImg = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImg != null) {
      pickedImage.value = File(pickedImg.path);
    }
  }

  bool customValidations() {
    isImageError.value = false;

    if (pickedImage.value.path == 'empty') {
      isImageError.value = true;
    }

    return isImageError.value;
  }

  void onSubmit() {
    if (customValidations()) {
      log('error');
      return;
    }

    sendImageToServer();
  }

  void sendImageToServer() async {
    log('sending image to server');
    isUploadImageLoading.value = true;

    final imageBody = {
      'image': pickedImage.value.path,
    };

    final response = await captionGenerationRepo.generateCaption(
      imageBody,
    );

    if (response.status == ApiStatus.SUCCESS) {
      log('response: ${response.response!.caption}');
      captionGenerationResponseApi.value = response.response!;
      isUploadImageLoading.value = false;
      // clear the image
      pickedImage.value = File('empty');

      Get.to(() => Result());
    } else {
      isUploadImageLoading.value = false;
      Fluttertoast.showToast(
          msg: response.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
