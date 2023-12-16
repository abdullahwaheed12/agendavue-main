import 'package:agendavue/presentation/district_dark_screen/district_dark_screen.dart';
import 'package:agendavue/presentation/loading_dark_screen/loading_dark_screen.dart';
import 'package:get/get.dart';

import '../models/signin_dark_model.dart';
import 'package:flutter/material.dart';

class SigninDarkController extends GetxController {
  TextEditingController enteryourschoController = TextEditingController();

  TextEditingController enteryourpassController = TextEditingController();

  Rx<SigninDarkModel> signinDarkModelObj = SigninDarkModel().obs;

  TextEditingController textController = TextEditingController();


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    enteryourschoController.dispose();
    enteryourpassController.dispose();
  }

  onTapBtnBack() {
    Get.back();
  }

  onTapBtnDistrict() {
    // Get.toNamed(AppRoutes.districtDarkScreen);
    Get.to(DistrictDarkScreen());
  }

  onTapBtnLogin() {
    // Get.toNamed(AppRoutes.loadingDarkScreen);
    Get.to(LoadingDarkScreen());
  }

  onTapTxtForgotpassword() {
    Get.snackbar('', "W");
  }
}
