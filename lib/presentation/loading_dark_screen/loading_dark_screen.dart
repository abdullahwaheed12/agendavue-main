import 'package:get/get.dart';

import '../../core/app_export.dart';
import '../pick_category_dark/pick_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee_vertical/marquee_vertical.dart';

class LoadingDarkScreen extends StatefulWidget {
  const LoadingDarkScreen({Key? key}) : super(key: key);

  @override
  _LoadingDarkScreenState createState() => _LoadingDarkScreenState();
}

final texts = [
  "Logging into AgendaVue",
  "Loading Grades",
  "Loading Schedule",
  "Loading Assignments",
  "Finalizing",
];

class _LoadingDarkScreenState extends State<LoadingDarkScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 5500), () {
      Get.to(PickCategoryScreen());
    });
    return Scaffold(
      backgroundColor: ColorConstant.darkModeBkg,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getHorizontalSize(250),
              height: getVerticalSize(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                color: ColorConstant.black,
              ),
              child: LoadingAnimationWidget.threeArchedCircle(
                size: 30,
                color: Colors.white,
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: getVerticalSize(5),
            ),
            MarqueeVertical(
              itemCount: texts.length,
              lineHeight: getVerticalSize(50),
              marqueeLine: 1,
              direction: MarqueeVerticalDirection.moveUp,
              itemBuilder: (index) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    texts[index],
                    style: AppStyle.poppinsRegural.copyWith(
                      fontSize: getFontSize(20),
                      color: ColorConstant.white,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: getHorizontalSize(0.2),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              scrollDuration: Duration(milliseconds: 300),
              stopDuration: Duration(milliseconds: 950),
            ),
          ],
        ),
      ),
    );
  }
}
