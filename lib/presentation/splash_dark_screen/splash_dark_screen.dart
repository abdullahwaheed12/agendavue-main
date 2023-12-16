import 'package:agendavue/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';

import '../onboarding_dark_screen/onboarding_dark_screen.dart';

class SplashDarkScreen extends StatefulWidget {
  @override
  State<SplashDarkScreen> createState() => _SplashDarkScreenState();
}

class _SplashDarkScreenState extends State<SplashDarkScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        var isRememberMe = GetStorage().read(rememberMeForLoginKey);
        if (isRememberMe == null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingDarkScreen(),
              ),
              (route) => false);
        } else if (isRememberMe) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AppNavigationScreen(),
              ),
              (route) => false);

          print('--->>>> remeber $isRememberMe');
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingDarkScreen(),
              ),
              (route) => false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        body: Container(
          width: size.width,
          child: Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CommonImageView(
                    svgPath: ImageConstant.onboardingLogo,
                    height: getVerticalSize(230.00),
                    width: getHorizontalSize(210.00),
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
