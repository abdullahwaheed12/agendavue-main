import 'package:agendavue/presentation/grades_dark_screen/grades_dark_screen.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_svg/flutter_svg.dart';
import '../home_dark_screen/homedarkScreen.dart';
import '../profile_dark_screen/profile_dark_screen.dart';

// ignore: must_be_immutable
class AppNavigationScreen extends StatefulWidget {
  @override
  State<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen> {
  var tabIndex = 1;
  Widget getbody() {
    if (tabIndex == 0) {
      return GradesDarkScreen();
    } else if (tabIndex == 1) {
      return HomeScreen();
    } else {
      return ProfileDarkScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: getbody(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        mouseCursor: SystemMouseCursors.alias,
        unselectedItemColor: ColorConstant.darkModeButtons,
        selectedItemColor: ColorConstant.white,
        backgroundColor: ColorConstant.darkModeSimple,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        currentIndex: tabIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.gradesIcon,
              color: ColorConstant.darkModeButtons,
              width: getHorizontalSize(25),
              height: getVerticalSize(25),
            ),
            label: 'Grades',
            activeIcon: SvgPicture.asset(
              ImageConstant.gradesFilledIcon,
              color: ColorConstant.white,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.homeIcon,
              width: getHorizontalSize(27),
              height: getVerticalSize(27),
              color: ColorConstant.darkModeButtons,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              ImageConstant.homeFilledIcon,
              width: getHorizontalSize(27),
              height: getVerticalSize(27),
              color: ColorConstant.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.profileIcon,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
              color: ColorConstant.darkModeButtons,
            ),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              ImageConstant.profileFilledIcon,
              color: ColorConstant.white,
              width: getHorizontalSize(30),
              height: getVerticalSize(30),
            ),
          ),
        ],
      ),
    );
  }
}
