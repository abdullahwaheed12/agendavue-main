import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final universalalarmControlller = ValueNotifier<bool>(false);
    final alarmSwitchControlller = ValueNotifier<bool>(false);
    final gradesSwitchControlller = ValueNotifier<bool>(false);

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsDarkScreen(),
                                ));
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
                            'Notification Settings',
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
                            controller: universalalarmControlller,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Universal Alarm",
                                  style: AppStyle.poppinsRegural.copyWith(
                                      fontSize: getFontSize(16.0),
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.snackbar("Univeral Alarm",
                                        "On turning on, you'll get alarm notification",
                                        backgroundColor: Colors.white,
                                        colorText: Colors.black);
                                  },
                                  child: Icon(
                                    Icons.info,
                                    size: 16,
                                    color: Color(0xFFBEBEBE),
                                  ),
                                )
                              ]),
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
                          trailing: AdvancedSwitch(
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            width: 56,
                            controller: alarmSwitchControlller,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only()),
                          tileColor: Color(0xFF242424),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Alarm",
                                  style: AppStyle.poppinsRegural.copyWith(
                                      fontSize: getFontSize(16.0),
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.snackbar("Alarm",
                                        "On turning on, you'll be able to set alarms",
                                        backgroundColor: Colors.white,
                                        colorText: Colors.black);
                                  },
                                  child: Icon(
                                    Icons.info,
                                    size: 16,
                                    color: Color(0xFFBEBEBE),
                                  ),
                                )
                              ]),
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
                          trailing: AdvancedSwitch(
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            width: 56,
                            controller: gradesSwitchControlller,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                          tileColor: Color(0xFF242424),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Grade Changes",
                                  style: AppStyle.poppinsRegural.copyWith(
                                      fontSize: getFontSize(16.0),
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.snackbar("Grade Changes",
                                        "On turning on, you'll be able to change your grades",
                                        backgroundColor: Colors.white,
                                        colorText: Colors.black);
                                  },
                                  child: Icon(
                                    Icons.info,
                                    size: 16,
                                    color: Color(0xFFBEBEBE),
                                  ),
                                )
                              ]),
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
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
