import 'package:agendavue/presentation/onboarding_dark_screen/onboarding_dark_screen.dart';
import 'package:get/get.dart';


class SplashDarkController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.off(OnboardingDarkScreen());
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
