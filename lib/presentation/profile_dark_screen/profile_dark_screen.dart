import 'package:agendavue/main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/general_controller.dart';
import '../../data/apiClient/soap_api/studentgradedata.dart';
import '../../data/apiClient/studentApiCall.dart';
import '../profile_detailed_screen/profile_detailed_screen.dart';
import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';
import 'controller/profile_dark_controller.dart';
import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable

class ProfileDarkScreen extends StatefulWidget {
  ProfileDarkScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDarkScreen> createState() => _ProfileDarkScreenState();
}

class _ProfileDarkScreenState extends State<ProfileDarkScreen> {
  //get color according to category as in figma
  String getBGColor(String name) {
    Map categories = GetStorage().read(districtSchoolKey);
    var categoryName = categories[name];
    switch (categoryName) {
      case 'Science':
        return ImageConstant.sciBgkdpng;
      case 'Social Studies':
        return ImageConstant.socialSciBgkdpng;
      case 'Computers':
        return ImageConstant.computerBkgdpng;
      case 'Arts':
        return ImageConstant.artBkgdpng;
      case 'Language':
        return ImageConstant.languageBgkdpng;
      case 'Math':
        return ImageConstant.mathBgkdpng;
      case 'Sports':
        return ImageConstant.sciBgkdpng;
      default:
        return ImageConstant.othersBgkdpng;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileDarkController());
    var generalController = Get.find<GeneralController>();
    return GetBuilder<ProfileDarkController>(builder: (controller) {
      //print('------>>>> photo ${generalController.studentData!.photo}');

      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.darkModeBkg,
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //upper part
              Container(
                padding: getPadding(
                  top: getVerticalSize(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //appbar
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
                                      child: Text(
                                        'No',
                                        style: GoogleFonts.poppins(
                                          color: ColorConstant.darkModeBkg,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.offAll(
                                          SigninDarkScreen(),
                                        );
                                        GetStorage().erase();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: GoogleFonts.poppins(
                                          color: ColorConstant.darkModeBkg,
                                        ),
                                      ),
                                    ),
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
                            left: getHorizontalSize(175),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: getHorizontalSize(28),
                            height: getVerticalSize(30),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            right: getHorizontalSize(40),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              //controller.onTapBtnNotifications();
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

                    //space
                    Padding(
                      padding: getPadding(
                        top: getVerticalSize(10),
                      ),
                    ),
                    //profile pic
                    Container(
                      alignment: Alignment.center,
                      width: getHorizontalSize(123),
                      height: getVerticalSize(123),
                      child: Stack(
                        children: [
                          //pic
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: getHorizontalSize(1.5),
                              ),
                            ),
                            child: Builder(builder: (context) {
                              if (generalController.studentData == null ||
                                  generalController
                                      .studentData!.photo!.isEmpty ||
                                  generalController.studentData!.photo ==
                                      null) {
                                return Image.network(
                                  'https://picsum.photos/200',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                );
                              } else {
                                var image = dataFromBase64String(
                                    generalController.studentData!.photo!);

                                return Container(
                                  height: 120,
                                  width: 115,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: (MemoryImage(
                                          image,
                                        )),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle),
                                  // child: Image.memory(
                                  //   image,
                                  //   fit: BoxFit.cover,
                                  // ),
                                );
                              }
                            }),
                          ),

                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: getHorizontalSize(40),
                                height: getVerticalSize(40),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: getHorizontalSize(40),
                                      height: getVerticalSize(40),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: getHorizontalSize(1),
                                        ),
                                        color: ColorConstant.darkModeBkg,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                            child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${generalController.studentData!.grade}',
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        getVerticalSize(15),
                                                    color: ColorConstant.white),
                                              ),
                                              TextSpan(
                                                text: 'th',
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        getVerticalSize(10),
                                                    color: ColorConstant.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        top: getVerticalSize(8),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          generalController.studentData?.formattedName ?? '',
                          style: GoogleFonts.rubik(
                            fontSize: getVerticalSize(27),
                            color: ColorConstant.white,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            top: getVerticalSize(5),
                          ),
                        ),
                        Text(
                          '${generalController.studentData?.currentSchool}',
                          style: GoogleFonts.alegreyaSans(
                            fontSize: getVerticalSize(20),
                            color: ColorConstant.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: getPadding(
                        top: getVerticalSize(20),
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: getHorizontalSize(70),
                        right: getHorizontalSize(70),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Divider(
                                color: ColorConstant.grey,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: getMargin(
                                  left: getHorizontalSize(65),
                                  right: getHorizontalSize(65),
                                ),
                                color: ColorConstant.darkModeBkg,
                                child: Text(
                                  'Schedule',
                                  style: GoogleFonts.rubik(
                                    fontSize: getVerticalSize(17),
                                    color: ColorConstant.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        top: getVerticalSize(12),
                      ),
                    ),
                  ],
                ),
              ),
              //courses
              Expanded(child: Builder(builder: (context) {
                return ListView.builder(
                  itemCount: StudentApiCall.studentDataFromCategory!.length,
                  itemBuilder: (context, index) {
                    if (StudentApiCall.studentDataFromCategory == null) {
                      debugPrint('--->>>> studentDataFromCategory is empty');
                      return SizedBox();
                    }
                    var studentDataFromCategory =
                        StudentApiCall.studentDataFromCategory![index];

                    print(studentDataFromCategory);

                    if (studentDataFromCategory.term.startAt == 'null' ||
                        studentDataFromCategory.term.endAt == 'null') {
                      return SizedBox();
                    }

                    // print(
                    //     'studentDataFromCategory.term.startAt ${studentDataFromCategory.term.startAt.runtimeType}');
                    // print(
                    //     'studentDataFromCategory.term.endAt ${studentDataFromCategory.term.endAt}');
                    // print(
                    //     '-->>> studentDataFromCategory ${studentDataFromCategory.name}');
                    return Padding(
                      padding: getPadding(
                        bottom: getVerticalSize(5),
                      ),
                      child: Container(
                        child: Padding(
                          padding: getPadding(
                            left: getHorizontalSize(15),
                            right: getHorizontalSize(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              GeneralController controller = Get.find();
                              SchoolClass schoolClass = SchoolClass();
                              int period = 0;
                              for (var element in controller.grades!.classes!) {
                                var b = element.className!.split(' ');

                                if (studentDataFromCategory.name
                                    .contains(b[0])) {
                                  schoolClass = element;
                                }
                              }
                              period = schoolClass.period!;
                              if (schoolClass.period == null) {
                                period = 0;
                              }

                              print('99999 $period');

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileDetailedScreen(
                                      studentDataFromCategory:
                                          studentDataFromCategory,
                                      period: period,
                                      schoolClass: schoolClass,
                                    ),
                                  ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: getHorizontalSize(330),
                                            height: getVerticalSize(140),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                getBGColor(
                                                    studentDataFromCategory
                                                        .name),
                                                fit: BoxFit.contain,
                                                // color: ColorConstant.grey,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: getPadding(
                                              top: getVerticalSize(7),
                                            ),
                                            width: getHorizontalSize(330),
                                            height: getVerticalSize(127),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromARGB(
                                                          255, 32, 32, 32)
                                                      .withOpacity(0.5),
                                                  Color.fromARGB(
                                                          255, 88, 88, 88)
                                                      .withOpacity(0.20),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              top: getVerticalSize(15),
                                              left: getHorizontalSize(15),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Text(
                                                    //   "Topic",
                                                    //   style: TextStyle(
                                                    //     color: Color(0xffbfb8b8),
                                                    //     fontSize: getFontSize(12),
                                                    //   ),
                                                    // ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Text(
                                                        studentDataFromCategory
                                                                    .name
                                                                    .length <
                                                                26
                                                            ? studentDataFromCategory
                                                                .name
                                                            : '${studentDataFromCategory.name.substring(0, 26)}...',
                                                        style:
                                                            GoogleFonts.rubik(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              getFontSize(18),
                                                          color: ColorConstant
                                                              .white,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: getPadding(
                                                        top:
                                                            getVerticalSize(10),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Period: ${index}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffbfb8b8),
                                                        fontSize:
                                                            getFontSize(16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                        ),
                      ),
                    );
                  },
                );
              })),
            ],
          ),
        ),
      );
    });
  }
}
