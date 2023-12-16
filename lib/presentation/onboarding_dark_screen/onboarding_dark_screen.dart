import '../district_dark_screen/district_dark_screen.dart';
import '../../core/app_export.dart';
import 'package:flutter/material.dart';

class OnboardingDarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        body: Container(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  top: 200,
                ),
                child: CommonImageView(
                  svgPath: ImageConstant.onboardingLogo,
                  height: getVerticalSize(
                    185.00,
                  ),
                  width: getHorizontalSize(
                    180.00,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 25,
                ),
                child: Text(
                  'AgendaVue',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppStyle.onBoardingTitle.copyWith(
                    letterSpacing: 1,
                    fontSize: getFontSize(45),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 10,
                ),
                child: Text(
                  'Personalized School Guide',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.onBoardingSubTitle.copyWith(
                    fontSize: getFontSize(16.25),
                  ),
                ),
              ),
              Container(
                height: getVerticalSize(
                  60.00,
                ),
                width: getHorizontalSize(
                  280.00,
                ),
                margin: getMargin(
                  top: 35,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DistrictDarkScreen(),
                        ));

                    // StudentClasses.getStuddentUpCoomingEventsData();
                  },
                  child: Text(
                    "Get Started",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.poppinsBold.copyWith(
                      fontSize: getFontSize(20),
                      color: ColorConstant.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.white,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
