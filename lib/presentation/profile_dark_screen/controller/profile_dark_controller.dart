import 'package:agendavue/presentation/onboarding_dark_screen/onboarding_dark_screen.dart';
import 'package:get/get.dart';

import '../models/profile_dark_model.dart';

class ProfileDarkController extends GetxController {
  Rx<ProfileDarkModel> profileDarkModelObj = ProfileDarkModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onTapBtnLogOut() {
    // Get.toNamed(AppRoutes.onboardingDarkScreen);
    Get.to(OnboardingDarkScreen());
  }

  List<String> className = <String>[
    'Hon Algebra 2B',
    'Music Technology B',
  ];
}
