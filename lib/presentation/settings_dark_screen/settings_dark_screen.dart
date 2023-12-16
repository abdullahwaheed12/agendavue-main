import 'package:agendavue/presentation/creator_dark/creator_dark_screen.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../signin_dark_screen/signin_dark_screen.dart';

class SettingsDarkScreen extends StatefulWidget {
  const SettingsDarkScreen({Key? key}) : super(key: key);

  @override
  State<SettingsDarkScreen> createState() => _SettingsDarkScreenState();
}

class _SettingsDarkScreenState extends State<SettingsDarkScreen> {
  @override
  Widget build(BuildContext context) {
    final darkModeController = ValueNotifier<bool>(true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: getPadding(
                top: getVerticalSize(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Alert!'),
                                content: Text('Do you want to logout'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        Get.offAll(
                                          SigninDarkScreen(),
                                        );
                                        GetStorage().erase();
                                      },
                                      child: Text('Yes')),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: getHorizontalSize(28),
                            height: getVerticalSize(30),
                            child: SvgPicture.asset(
                              ImageConstant.logoutIcon,
                              color: ColorConstant.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: getHorizontalSize(250),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SettingsDarkScreen(),
                            //     ));
                          },
                          child: Container(
                            width: getHorizontalSize(28),
                            height: getVerticalSize(30),
                            child: SvgPicture.asset(
                              ImageConstant.settingsIcon,
                              color: ColorConstant.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: getPadding(
                      top: getVerticalSize(20),
                    ),
                  ),
                  Divider(
                    color: ColorConstant.grey,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            'Settings',
                            style: AppStyle.poppinsRegural.copyWith(
                              fontSize: getFontSize(18.0),
                              color: ColorConstant.grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: AdvancedSwitch(
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            width: 56,
                            controller: darkModeController,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Light Mode",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 1,
                          child: Container(color: Color(0xFF4F4F4F)),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10, right: 10),
                      //   child: ListTile(
                      //     trailing: IconButton(
                      //       icon: Icon(
                      //         Icons.arrow_forward_ios,
                      //         color: ColorConstant.white,
                      //         size: 16,
                      //       ),
                      //       onPressed: () {},
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only()),
                      //     tileColor: Color(0xFF242424),
                      //     title: Text(
                      //       "Notification Settings",
                      //       style: AppStyle.poppinsRegural.copyWith(
                      //           fontSize: getFontSize(16.0),
                      //           color: ColorConstant.white,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 1,
                          child: Container(color: Color(0xFF4F4F4F)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 16,
                            ),
                            onPressed: () {
                              Get.snackbar(
                                  "Page in Construction", "Coming soon!",
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           NotificationSettingScreen(),
                              //     ));
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Notification Settings",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 16,
                            ),
                            onPressed: () {
                              Get.to(CreatorDarkScreen());
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Creator",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 1,
                          child: Container(color: Color(0xFF4F4F4F)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              Get.snackbar(
                                  "Page in Construction", "Coming soon!",
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black);
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only()),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Terms of Use",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 1,
                          child: Container(color: Color(0xFF4F4F4F)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              Get.snackbar(
                                  "Page in Construction", "Coming soon!",
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black);
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Privacy Policy",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Leave a review on the App Store!')));
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Text(
                            "Feedback",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(16.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: getVerticalSize(30),
                        ),
                      ),
                      Divider(
                        color: ColorConstant.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "Made by a student, for students",
                          style: AppStyle.poppinsRegural.copyWith(
                              fontSize: getFontSize(18.0),
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
