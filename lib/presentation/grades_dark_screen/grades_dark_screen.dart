import 'package:agendavue/controllers/general_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/apiClient/soap_api/studentgradedata.dart';
import '../grades_detailed_screen/grades_detailed_screen.dart';
import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class GradesDarkScreen extends StatefulWidget {
  const GradesDarkScreen({Key? key}) : super(key: key);

  @override
  State<GradesDarkScreen> createState() => _GradesDarkScreenState();
}

class _GradesDarkScreenState extends State<GradesDarkScreen> {
  final List<String> items = [
    'Others',
  ];
  var selectedValue;

  //  converting integer number into ordial number forexamble 1 into 1st, 2 into 2nd etc
  String ordinal(int number) {
    if (number < 1 || number > 100)
      return ''; // check if number is within range

    // check if number is in the teens, return 'th'
    if (number >= 11 && number <= 13) return 'th';

    // check the last digit of the number and return the appropriate ordinal suffix
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // String getLetterFromPctGrade(String pctGrade) {
  //   if (pctGrade == null || pctGrade == 'N/A') return '';
  //   double? grade = double.tryParse(pctGrade);
  //   if (grade == null) return '';
  //   if (grade >= 89.5)
  //     return 'A';
  //   else if (grade >= 79.5)
  //     return 'B';
  //   else if (grade >= 69.5)
  //     return 'C';
  //   else if (grade >= 59.5)
  //     return 'D';
  //   else if (grade >= 00.1)
  //     return 'E';
  //   else
  //     return 'N/A';
  // }

  // List<Color> getColorFromPctGrade(String pctGrade) {
  //   double? grade = double.tryParse(pctGrade);

  //   if (grade == null) return [Colors.black54, Colors.black54];

  //   if (grade >= 89.5) {
  //     return [Color(0xff166E32), Color(0xff166E32)];
  //   } else if (grade >= 79.5) {
  //     return [Color(0xff033981), Color(0xff173A67)];
  //   } else if (grade >= 69.5) {
  //     return [Color(0xff7D802E), Color(0xff575C29)];
  //   } else if (grade >= 59.5) {
  //     return [Color(0xffBB6A23), Color(0xff684127)];
  //   } else if (grade >= 00.1) {
  //     return [Color(0xffB83F3F), Color(0xff5E202A)];
  //   } else {
  //     return [
  //       Color.fromARGB(135, 102, 102, 102),
  //       Color.fromARGB(135, 51, 51, 51),
  //     ];
  //   }
  // }

  // Color getCircleColor(String pctGrade) {
  //   double? grade = double.tryParse(pctGrade);
  //   if (grade == null || pctGrade == 'N/A') return Colors.black54;
  //   if (grade >= 89.5) {
  //     return Colors.green;
  //   } else if (grade >= 79.5) {
  //     return Colors.blue;
  //   } else if (grade >= 69.5) {
  //     return Colors.yellow;
  //   } else if (grade >= 59.5) {
  //     return Colors.orange;
  //   } else if (grade >= 00.1) {
  //     return Colors.red;
  //   } else {
  //     return Color.fromARGB(255, 143, 143, 143);
  //   }
  // }

  late String letter;
  late List<Color> colors;
  late Color circleColor;

  void getGradeInfo(String pctGrade) {
    double? grade = double.tryParse(pctGrade);

    final gradeLookupTable = {
      89.5: {
        'letter': 'A',
        'colors': [Color(0xff166E32), Color(0xff166E32)],
        'circleColor': Colors.green
      },
      79.5: {
        'letter': 'B',
        'colors': [Color(0xff033981), Color(0xff173A67)],
        'circleColor': Colors.blue
      },
      69.5: {
        'letter': 'C',
        'colors': [Color(0xff7D802E), Color(0xff575C29)],
        'circleColor': Colors.yellow
      },
      59.5: {
        'letter': 'D',
        'colors': [Color(0xffBB6A23), Color(0xff684127)],
        'circleColor': Colors.orange
      },
      00.00: {
        'letter': 'E',
        'colors': [Color(0xffB83F3F), Color(0xff5E202A)],
        'circleColor': Colors.red
      },
      null: {
        'letter': 'N/A',
        'colors': [
          Color.fromARGB(135, 102, 102, 102),
          Color.fromARGB(135, 51, 51, 51)
        ],
        'circleColor': Color.fromARGB(255, 143, 143, 143)
      },
    };

    if (grade == null || pctGrade == 'N/A') {
      this.letter = gradeLookupTable[null]!['letter'] as String;
      this.colors = gradeLookupTable[null]!['colors'] as List<Color>;
      this.circleColor = gradeLookupTable[null]!['circleColor'] as Color;
      return;
    }

    for (double? key in gradeLookupTable.keys) {
      if (grade >= key!) {
        this.letter = gradeLookupTable[key]!['letter'] as String;
        this.colors = gradeLookupTable[key]!['colors'] as List<Color>;
        this.circleColor = gradeLookupTable[key]!['circleColor'] as Color;
        return;
      }
    }
  }

  var loader = false;
  @override
  Widget build(BuildContext context) {
    print(000000);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(color: Colors.white),
          inAsyncCall: loader,
          child: GetBuilder<GeneralController>(builder: (controller) {
            return Container(
              padding: getPadding(
                top: getVerticalSize(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  Padding(
                    padding: getPadding(
                      top: getVerticalSize(20),
                    ),
                  ),
                  Center(
                    child: categories(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Cumulative CGPA: J',
                        style: AppStyle.poppinsRegural.copyWith(
                          fontSize: getFontSize(20.0),
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.grades!.classes!.length,
                          itemBuilder: (context, index) {
                            var schoolClass =
                                controller.grades!.classes![index];
                            if (controller.grades!.classes == null ||
                                schoolClass.period! < 1) {
                              debugPrint(
                                  '--->>>> studentDataFromCategory is empty');
                              return SizedBox();
                            }

                            getGradeInfo(schoolClass.pctGrade!);

                            if (double.tryParse(schoolClass.pctGrade!) == 0.0) {
                              letter = 'N/A';
                              colors = [
                                Color.fromARGB(135, 102, 102, 102),
                                Color.fromARGB(135, 51, 51, 51)
                              ];
                              circleColor = Color.fromARGB(255, 143, 143, 143);
                            }

                            var latterFromGrade = letter;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GradesDetailedScreen(
                                              schoolClass: schoolClass),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15.0, bottom: 10, top: 10),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: colors,
                                      ),
                                      border: Border.all(
                                          color: circleColor, width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Stack(children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: CircularPercentIndicator(
                                            fillColor: Colors.transparent,
                                            backgroundColor: Colors.white,
                                            radius: 34.0,
                                            lineWidth: 5.0,
                                            percent: double.parse(
                                                    schoolClass.pctGrade!) /
                                                100,
                                            center: Text(
                                              latterFromGrade,
                                              // schoolClass.letterGrade ?? '',
                                              style: TextStyle(
                                                  fontFamily: "poppinsBold",
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            progressColor: circleColor,
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 20),
                                        child: Text(
                                          schoolClass.className!.length < 26
                                              ? schoolClass.className!
                                              : '${schoolClass.className!.substring(0, 26)}...',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 25, left: 20),
                                        child: Text(
                                          "${schoolClass.period!}${ordinal(schoolClass.period ?? 0)} Period",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFBEBEBE)),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Row categories() {
    var controller = Get.find<GeneralController>();
    var a = controller.grades?.reportingPeriods;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: getVerticalSize(44),
          width: getHorizontalSize(150),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: [
                  Text(
                    selectedValue != null
                        ? selectedValue.name
                        : controller.grades?.currentMp ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              items: a!
                  .map((item) => DropdownMenuItem<ReportingPeriods>(
                        value: item,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              // value: selectedValue,

              onChanged: (value) {
                selectedValue = value;
                // loader = true;
                // controller
                //     .loadNewGradeBookk(selectedValue.value ?? '1')
                //     .then((value) {
                //   loader = false;

                //   setState(() {});
                // });
                controller.grades =
                    controller.listOfGrades[int.parse(value!.value)];
                setState(() {});
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              iconSize: 20,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 150,
              buttonPadding: const EdgeInsets.only(left: 20, right: 20),
              buttonDecoration: BoxDecoration(
                color: Color(0xFF282828),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 200,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF282828),
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
            ),
          ),
        ),
      ],
    );
  }
}
