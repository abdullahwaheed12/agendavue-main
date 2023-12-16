import 'package:agendavue/data/apiClient/studentApiCall.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/apiClient/soap_api/studentgradedata.dart';
import '../../data/models/class_student.dart';
import '../../data/models/select_category.dart' hide State;
import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class ProfileDetailedScreen extends StatefulWidget {
  const ProfileDetailedScreen(
      {Key? key,
      required this.studentDataFromCategory,
      required this.period,
      required this.schoolClass})
      : super(key: key);
  final SelectCategory studentDataFromCategory;
  final int period;
  final SchoolClass schoolClass;
  @override
  State<ProfileDetailedScreen> createState() => _ProfileDetailedScreenState();
}

class _ProfileDetailedScreenState extends State<ProfileDetailedScreen> {
  var loader = true;
  late List<ClassStudent> classStudent;

  @override
  void initState() {
    // if (StudentApiCall.classStudent != null) {
    // } else {
    getClassStudent();
    // }
    super.initState();
  }

  getClassStudent() {
    StudentApiCall.getClassStudent(widget.studentDataFromCategory.id.toString())
        .then((value) {
      loader = false;
      classStudent = StudentApiCall.classStudent!;

      classStudent = value ?? [];

      if (mounted) setState(() {});
    });
  }

  Color getCircleColor(String pctGrade) {
    // if (pctGrade == 'N/A') return Colors.black54;
    double grade = pctGrade.isNotEmpty ? double.parse(pctGrade) : 78.6;
    // if (grade == null) return Colors.black54;
    if (grade >= 89.5) {
      return Color(0xff16DF54);
    } else if (grade >= 79.5) {
      return Color(0xff016EFF);
    } else if (grade >= 69.5) {
      return Color(0xffF9FF00);
    } else if (grade >= 79.5) {
      return Color(0xffF2994B);
    } else {
      return Color(0xffFF0200);
    }
  }

  String ordinal(int number) {
    if (!(number >= 1 && number <= 100)) {
      return '';
      //here you change the range
      // throw Exception('Invalid number');
    }

    if (number >= 11 && number <= 13) {
      return 'th';
    }

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

  List<Color> getColorFromPctGrade(String pctGrade) {
    // if (pctGrade == 'N/A') return Colors.black54;
    double grade = pctGrade.isNotEmpty ? double.parse(pctGrade) : 78.6;
    // if (grade == null) return Colors.black54;
    if (grade >= 89.5) {
      return [Color(0xff166E32), Color(0xff166E32)];
    } else if (grade >= 79.5) {
      return [Color(0xff033981), Color(0xff173A67)];
    } else if (grade >= 69.5) {
      return [Color(0xff7D802E), Color(0xff575C29)];
    } else if (grade >= 79.5) {
      return [Color(0xffBB6A23), Color(0xff684127)];
    } else {
      return [Color(0xffB83F3F), Color(0xff5E202A)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: Container(
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
              //space
              Padding(
                padding: getPadding(
                  top: getVerticalSize(35),
                ),
              ),
              if (widget.schoolClass.pctGrade == null)

                //header dummy
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF006A26),
                            Color(0xFF004615),
                          ],
                        ),
                        border:
                            Border.all(color: Color(0xFF00E238), width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              percent: 0.92,
                              center: Text(
                                "92%",
                                style: TextStyle(
                                    fontFamily: "poppinsBold",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: Color(0xFF00E338),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            widget.studentDataFromCategory.name.length < 24
                                ? widget.studentDataFromCategory.name
                                : '${widget.studentDataFromCategory.name.substring(0, 24)}...',
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
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            "Room: 3004",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBEBEBE)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15, left: 20),
                          child: Text(
                            "${widget.period}${ordinal(widget.period)} Period",
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
              if (widget.schoolClass.pctGrade != null)

                //header
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: getColorFromPctGrade(
                              widget.schoolClass.pctGrade ?? ''),
                        ),
                        border: Border.all(
                            color: getCircleColor(
                                widget.schoolClass.pctGrade ?? '')),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              percent: widget.schoolClass.pctGrade != null
                                  ? double.parse(widget.schoolClass.pctGrade!) /
                                      100
                                  : 1,
                              center: Text(
                                "${widget.schoolClass.pctGrade}%",
                                style: TextStyle(
                                    fontFamily: "poppinsBold",
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: getCircleColor(
                                  widget.schoolClass.pctGrade ?? ''),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            widget.schoolClass.className!.length < 26
                                ? widget.schoolClass.className!
                                : '${widget.schoolClass.className!.substring(0, 26)}...',
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
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            widget.schoolClass.roomNumber ?? '',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBEBEBE)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15, left: 20),
                          child: Text(
                            "${widget.period}${ordinal(widget.period)} Period",
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
              if (widget.schoolClass.pctGrade == null)

                //sub heading dummy
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(),
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFF007229),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            border: Border.all(
                              width: 1.5,
                              color: Color(0xFF00E238),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Karen Kraus',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFF007229),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            border: Border.all(
                              width: 1.5,
                              color: Color(0xFF00E238),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  '${DateFormat('hh:mm a').format(DateTime.parse(widget.studentDataFromCategory.term.startAt))} - ${DateFormat('hh:mm a').format(DateTime.parse(widget.studentDataFromCategory.term.endAt))}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.schoolClass.pctGrade != null)
//sub heading
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //person name
                    Container(
                      height: 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: getColorFromPctGrade(
                              widget.schoolClass.pctGrade ?? ''),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(
                          width: 1.5,
                          color:
                              getCircleColor(widget.schoolClass.pctGrade ?? ''),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_pin,
                            size: 20,
                            color: Colors.grey[300],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.schoolClass.classTeacher ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: GoogleFonts.rubik().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                    //timing
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: getColorFromPctGrade(
                              widget.schoolClass.pctGrade ?? ''),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(
                          width: 1.5,
                          color:
                              getCircleColor(widget.schoolClass.pctGrade ?? ''),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${DateFormat('hh:mm a').format(DateTime.parse(widget.studentDataFromCategory.term.startAt))} - ${DateFormat('hh:mm a').format(DateTime.parse(widget.studentDataFromCategory.term.endAt))}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                    ),
                  ],
                ),

              SizedBox(
                height: 20,
              ),
              //search bar
              Padding(
                padding: EdgeInsets.only(
                  left: getHorizontalSize(20),
                  right: getHorizontalSize(20),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: getVerticalSize(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              loader = false;
                              setState(() {});
                              getClassStudent();

                              return;
                            }
                            List<ClassStudent> s = [];

                            value = value
                                .toLowerCase(); // Make the search value case-insensitive

                            for (var element in classStudent) {
                              if (element.sortableName!
                                  .toLowerCase()
                                  .contains(value)) {
                                s.add(element);
                              }
                            }
                            classStudent = s;
                            setState(() {});
                            print('pppppp $s');
                          },
                          decoration: InputDecoration(
                            fillColor: ColorConstant.darkModeUi,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.white,
                              ),
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(42),
                              ),
                            ),
                            hintText: "Search for students",
                            alignLabelWithHint: true,
                            hintStyle: AppStyle.poppinsRegural.copyWith(
                              fontSize: getFontSize(17.0),
                              color: ColorConstant.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.grey,
                              ),
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(42),
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: getPadding(
                                left: getHorizontalSize(15),
                                right: getHorizontalSize(5),
                              ),
                              child: Icon(
                                Icons.search,
                                color: ColorConstant.white,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: getHorizontalSize(20),
                              right: getHorizontalSize(20),
                            ),
                          ),
                          style: AppStyle.poppinsRegural.copyWith(
                            fontSize: getFontSize(17.0),
                            color: ColorConstant.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 1,
              ),

              Expanded(
                  child: loader
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : ListView.separated(
                          itemCount: classStudent.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                color: Colors.grey[700],
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 30, right: 20, top: 20),
                              child: Text(
                                classStudent[index].sortableName ?? 'null',
                                style: AppStyle.poppinsRegural.copyWith(
                                    fontSize: getFontSize(18.0),
                                    color: ColorConstant.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
