import 'package:get/get.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgotDarkScreen extends StatefulWidget {
  @override
  State<ForgotDarkScreen> createState() => _ForgotDarkScreenState();
}

class _ForgotDarkScreenState extends State<ForgotDarkScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: getPadding(
                  top: getVerticalSize(50),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: getHorizontalSize(55),
                                    height: getVerticalSize(65),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: ColorConstant.darkModeButtons,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: ColorConstant.white,
                                      size: getVerticalSize(35),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: getPadding(
                  top: getVerticalSize(40),
                  left: getHorizontalSize(30),
                ),
                child: Text(
                  'Reset password',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.onBoardingTitle.copyWith(
                    letterSpacing: 1,
                    fontSize: getFontSize(35),
                  ),
                ),
              ),
              Container(
                padding: getPadding(
                  top: getVerticalSize(15),
                  left: getHorizontalSize(30),
                  right: getHorizontalSize(20),
                ),
                child: Text(
                  'We will send you a link to your school email to reset your password',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(16.2),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(20),
                ),
              ),
              Container(
                padding: getPadding(
                  left: getHorizontalSize(30),
                  right: getHorizontalSize(25),
                ),
                child: TextFormField(
                  cursorColor: Colors.white,
                  key: _formKey,
                  keyboardType: TextInputType.emailAddress,
                  // controller: controller.enteryourschoController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Enter your school email",
                    hintStyle: AppStyle.poppinsRegural.copyWith(
                      fontSize: getFontSize(17.0),
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.white,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: getPadding(
                        left: getHorizontalSize(10),
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        color: ColorConstant.white,
                        size: getHorizontalSize(20),
                      ),
                    ),
                    filled: true,
                    fillColor: ColorConstant.darkModeFormField,
                  ),
                  style: TextStyle(
                    fontSize: getFontSize(18.0),
                    color: ColorConstant.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(40),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Send",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.poppinsBold.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: getFontSize(20),
                      color: ColorConstant.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.white,
                    alignment: Alignment.center,
                    minimumSize: Size(
                      getHorizontalSize(300),
                      getVerticalSize(60),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
