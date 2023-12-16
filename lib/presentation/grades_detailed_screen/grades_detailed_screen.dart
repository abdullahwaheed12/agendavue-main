import 'dart:async';

import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:string_similarity/string_similarity.dart';
import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/grade_colors.dart';

import '../../data/apiClient/soap_api/studentgradedata.dart';
import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class GradesDetailedScreen extends StatefulWidget {
  const GradesDetailedScreen({Key? key, required this.schoolClass})
      : super(key: key);
  final SchoolClass schoolClass;

  @override
  State<GradesDetailedScreen> createState() => _GradesDetailedScreenState();
}

class _GradesDetailedScreenState extends State<GradesDetailedScreen> {
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

  String marks = '';
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // if failed,use refreshFailed()
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return GradesDetailedScreen(
          schoolClass: widget.schoolClass,
        );
      },
    ));
    marks = '';

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  late String letter;
  late List<Color> colors;
  late Color circleColor;

  String gradeChangeAlgo(
    String newPointsEarnedAssignment,
    double oldPointsEarnedAssignment,
    double totalPointsPossibleAssignment,
    String categoryName,
    Object category,
    String assignmentType,
  ) {
    print('STARTING GRADE CHANGE ALGO!');
    //For getting the correct category
    AssignmentCategory getCategoryByName(String name) {
      for (var obj in widget.schoolClass.assignmentCategories!) {
        if (obj.name.similarityTo(name) >= 0.7) {
          return obj;
        }
      }

      //If the category is not found, return a default category
      return AssignmentCategory(
        earnedPoints: 0.0,
        possiblePoints: 0.0,
        weight: 0.0,
        name: "Default Category",
      );
    }

    AssignmentCategory? allTasksCategory =
        getCategoryByName("All Tasks / Assessments");
    AssignmentCategory? homeworkCategory =
        getCategoryByName("Practice / Preparation");

    //First specify the weight of each category and how much you've earned in each category
    double allTaskEarned = allTasksCategory.earnedPoints!;
    print('allTaskEarned: $allTaskEarned');
    double allTaskTotal = allTasksCategory.possiblePoints!;
    print('allTaskEarned: $allTaskEarned');

    double homeworkEarned = homeworkCategory.earnedPoints!;
    print('homeworkEarned: $homeworkEarned');
    double homeworkTotal = homeworkCategory.possiblePoints!;
    print('homeworkEarned: $homeworkEarned');

    //then you would get the pointsEarned for the assignment
    double pointsEarnedForAssignment = oldPointsEarnedAssignment;
    print('pointsEarnedForAssignment: $pointsEarnedForAssignment');

    //then you would get the total points possible for the assignment
    double pointsPossibleForAssignment = totalPointsPossibleAssignment;
    print('pointsEarnedForAssignment: $pointsEarnedForAssignment');

    //then you would get the assignment's category weight
    double assignmentCategoryWeight;

    double? desiredPointsEarnedForAssignment =
        double.tryParse(newPointsEarnedAssignment);
    print(
        'desiredPointsEarnedForAssignment: $desiredPointsEarnedForAssignment');
    double desiredPointsPossibleForAssignment = pointsPossibleForAssignment;
    print(
        'desiredPointsPossibleForAssignment: $desiredPointsPossibleForAssignment');

    switch (assignmentType) {
      case 'Practice / Preparation':
        assignmentCategoryWeight = homeworkCategory.weight!;
        print('assignmentCategoryWeight: $assignmentCategoryWeight');
        homeworkEarned -= pointsEarnedForAssignment;
        print(
            'homeworkEarned: $homeworkEarned = $homeworkEarned - $pointsEarnedForAssignment');
        homeworkTotal -= pointsPossibleForAssignment;
        print(
            'homeworkTotal: $homeworkTotal = $homeworkTotal - $pointsPossibleForAssignment');
        homeworkEarned += desiredPointsEarnedForAssignment!;
        print(
            'homeworkEarned: $homeworkEarned = $homeworkEarned + $desiredPointsEarnedForAssignment');
        homeworkTotal += desiredPointsPossibleForAssignment;
        print(
            'homeworkTotal: $homeworkTotal = $homeworkTotal + $desiredPointsPossibleForAssignment');
        break;
      case 'All Tasks / Assessments':
        assignmentCategoryWeight = allTasksCategory.weight!;
        print('assignmentCategoryWeight: $assignmentCategoryWeight');
        allTaskEarned -= pointsEarnedForAssignment;
        print(
            'allTaskEarned: $allTaskEarned = $allTaskEarned - $pointsEarnedForAssignment');
        allTaskTotal -= pointsPossibleForAssignment;
        print(
            'allTaskTotal: $allTaskTotal = $allTaskTotal - $pointsPossibleForAssignment');
        allTaskEarned += desiredPointsEarnedForAssignment!;
        print(
            'allTaskEarned: $allTaskEarned = $allTaskEarned + $desiredPointsEarnedForAssignment');
        allTaskTotal += desiredPointsPossibleForAssignment;
        print(
            'allTaskTotal: $allTaskTotal = $allTaskTotal + $desiredPointsPossibleForAssignment');
        break;
      default:
        assignmentCategoryWeight = 0.0;
    }

    //calculate the new total percentage earned for each category
    double allTaskPct = allTaskEarned == 0 || allTaskTotal == 0
        ? 0.0
        : allTaskEarned / allTaskTotal;
    print('allTaskPct: $allTaskPct =  $allTaskEarned / $allTaskTotal');
    double homeworkPct = homeworkEarned == 0 || homeworkTotal == 0
        ? 0.0
        : homeworkEarned / homeworkTotal;
    print('homeworkPct: $homeworkPct = $homeworkEarned / $homeworkTotal');

    //calculate the new total percentage weighted earned for each category
    double allTaskWeightedPct;
    double homeworkWeightedPct;
    if (allTaskEarned == 0 || allTaskTotal == 0) {
      print('allTaskEarned: $allTaskEarned');
      allTaskWeightedPct = 0;
      print('allTaskWeightedPct: $allTaskWeightedPct');
      homeworkWeightedPct = homeworkPct * 100;
      print('homeworkWeightedPct: $homeworkWeightedPct');
    } else {
      allTaskWeightedPct = allTaskPct * allTasksCategory.weight!;
      print('allTaskWeightedPct: $allTaskWeightedPct');
    }

    if (homeworkEarned == 0 || homeworkTotal == 0) {
      print('homeworkEarned: $homeworkEarned');
      homeworkWeightedPct = 0;
      print('homeworkWeightedPct: $homeworkWeightedPct');
      allTaskWeightedPct = allTaskPct * 100;
      print('allTaskWeightedPct: $allTaskWeightedPct = $allTaskPct * 100');
    } else {
      homeworkWeightedPct = homeworkPct * homeworkCategory.weight!;
      print(
          'homeworkWeightedPct: $homeworkWeightedPct = $homeworkPct * ${homeworkCategory.weight}');
    }

    //calculate the new total percentage weighted earned for the class
    String totalWeightedPct =
        (allTaskWeightedPct + homeworkWeightedPct).toStringAsFixed(2);
    print(
        'totalWeightedPct: $totalWeightedPct = $allTaskWeightedPct + $homeworkWeightedPct');

    return totalWeightedPct;
  }

  //For getting the boost value for each assingment
  String? getBoost(
    String boostType,
    double oldPointsEarnedAssignment,
    double totalPointsPossibleAssignment,
    String categoryName,
    Object category,
    String assignmentType,
  ) {
    print('STARTING BOOST CALCULATION');
    //For getting the correct category
    AssignmentCategory getCategoryByName(String name) {
      for (var obj in widget.schoolClass.assignmentCategories!) {
        if (obj.name.similarityTo(name) >= 0.7) {
          return obj;
        }
      }

      //If the category is not found, return a default category
      return AssignmentCategory(
        earnedPoints: 0.0,
        possiblePoints: 0.0,
        weight: 0.0,
        name: "Default Category",
      );
    }

    AssignmentCategory? allTasksCategory =
        getCategoryByName("All Tasks / Assessments");
    AssignmentCategory? homeworkCategory =
        getCategoryByName("Practice / Preparation");

    //First specify the weight of each category and how much you've earned in each category
    double allTaskEarned = allTasksCategory.earnedPoints!;
    print('allTaskEarned: $allTaskEarned');
    double allTaskTotal = allTasksCategory.possiblePoints!;
    print('allTaskEarned: $allTaskEarned');

    double homeworkEarned = homeworkCategory.earnedPoints!;
    print('homeworkEarned: $homeworkEarned');
    double homeworkTotal = homeworkCategory.possiblePoints!;
    print('homeworkEarned: $homeworkEarned');

    //then you would get the pointsEarned for the assignment
    double pointsEarnedForAssignment = oldPointsEarnedAssignment;
    print('pointsEarnedForAssignment: $pointsEarnedForAssignment');

    //then you would get the total points possible for the assignment
    double pointsPossibleForAssignment = totalPointsPossibleAssignment;
    print('pointsEarnedForAssignment: $pointsEarnedForAssignment');

    //then you would get the assignment's category weight
    double assignmentCategoryWeight;

    double? desiredPointsEarnedForAssignment = pointsPossibleForAssignment;
    if (boostType == 'Zero') {
      desiredPointsEarnedForAssignment = 0.0;
    } else if (boostType == 'Full') {
      desiredPointsEarnedForAssignment = pointsPossibleForAssignment;
    }
    print(
        'desiredPointsEarnedForAssignment: $desiredPointsEarnedForAssignment');
    double desiredPointsPossibleForAssignment = pointsPossibleForAssignment;
    if (boostType == 'Zero') {
      desiredPointsPossibleForAssignment = 0.0;
    } else if (boostType == 'Full') {
      desiredPointsPossibleForAssignment = pointsPossibleForAssignment;
    }
    print(
        'desiredPointsPossibleForAssignment: $desiredPointsPossibleForAssignment');

    switch (assignmentType) {
      case 'Practice / Preparation':
        assignmentCategoryWeight = homeworkCategory.weight!;
        print('assignmentCategoryWeight: $assignmentCategoryWeight');
        homeworkEarned -= pointsEarnedForAssignment;
        print(
            'homeworkEarned: $homeworkEarned = $homeworkEarned - $pointsEarnedForAssignment');
        homeworkTotal -= pointsPossibleForAssignment;
        print(
            'homeworkTotal: $homeworkTotal = $homeworkTotal - $pointsPossibleForAssignment');
        homeworkEarned += desiredPointsEarnedForAssignment;
        print(
            'homeworkEarned: $homeworkEarned = $homeworkEarned + $desiredPointsEarnedForAssignment');
        homeworkTotal += desiredPointsPossibleForAssignment;
        print(
            'homeworkTotal: $homeworkTotal = $homeworkTotal + $desiredPointsPossibleForAssignment');
        break;
      case 'All Tasks / Assessments':
        assignmentCategoryWeight = allTasksCategory.weight!;
        print('assignmentCategoryWeight: $assignmentCategoryWeight');
        allTaskEarned -= pointsEarnedForAssignment;
        print(
            'allTaskEarned: $allTaskEarned = $allTaskEarned - $pointsEarnedForAssignment');
        allTaskTotal -= pointsPossibleForAssignment;
        print(
            'allTaskTotal: $allTaskTotal = $allTaskTotal - $pointsPossibleForAssignment');
        allTaskEarned += desiredPointsEarnedForAssignment;
        print(
            'allTaskEarned: $allTaskEarned = $allTaskEarned + $desiredPointsEarnedForAssignment');
        allTaskTotal += desiredPointsPossibleForAssignment;
        print(
            'allTaskTotal: $allTaskTotal = $allTaskTotal + $desiredPointsPossibleForAssignment');
        break;
      default:
        assignmentCategoryWeight = 0.0;
    }

    //calculate the new total percentage earned for each category
    double allTaskPct = allTaskEarned == 0 || allTaskTotal == 0
        ? 0.0
        : allTaskEarned / allTaskTotal;
    print('allTaskPct: $allTaskPct =  $allTaskEarned / $allTaskTotal');
    double homeworkPct = homeworkEarned == 0 || homeworkTotal == 0
        ? 0.0
        : homeworkEarned / homeworkTotal;
    print('homeworkPct: $homeworkPct = $homeworkEarned / $homeworkTotal');

    //calculate the new total percentage weighted earned for each category
    double allTaskWeightedPct;
    double homeworkWeightedPct;
    if (allTaskEarned == 0 || allTaskTotal == 0) {
      print('allTaskEarned: $allTaskEarned');
      allTaskWeightedPct = 0;
      print('allTaskWeightedPct: $allTaskWeightedPct');
      homeworkWeightedPct = homeworkPct * 100;
      print('homeworkWeightedPct: $homeworkWeightedPct');
    } else {
      allTaskWeightedPct = allTaskPct * allTasksCategory.weight!;
      print('allTaskWeightedPct: $allTaskWeightedPct');
    }

    if (homeworkEarned == 0 || homeworkTotal == 0) {
      print('homeworkEarned: $homeworkEarned');
      homeworkWeightedPct = 0;
      print('homeworkWeightedPct: $homeworkWeightedPct');
      allTaskWeightedPct = allTaskPct * 100;
      print('allTaskWeightedPct: $allTaskWeightedPct = $allTaskPct * 100');
    } else {
      homeworkWeightedPct = homeworkPct * homeworkCategory.weight!;
      print(
          'homeworkWeightedPct: $homeworkWeightedPct = $homeworkPct * ${homeworkCategory.weight}');
    }

    //calculate the new total percentage weighted earned for the class
    String totalWeightedPct =
        (allTaskWeightedPct + homeworkWeightedPct).toStringAsFixed(2);
    print(
        'totalWeightedPct: $totalWeightedPct = $allTaskWeightedPct + $homeworkWeightedPct');
    return totalWeightedPct;
  }

  double? pctIncrease(String? from, String? to) {
    if (to == null || from == null) {
      return 0;
    }
    double numFrom = double.parse(from);
    double numTo = double.parse(to);
    return ((numTo - numFrom) / numFrom) * 100;
  }

  @override
  Widget build(BuildContext context) {
    //print('000000 ${widget.schoolClass}');

    var a = widget.schoolClass.className;

    //line below is required so that the colors are built
    var gradeUtils = GradeUtils(pctGrade: widget.schoolClass.pctGrade!);
    letter = gradeUtils.getLetter();
    colors = gradeUtils.getColors();
    circleColor = gradeUtils.getCircleColor();

    int? boostPct = 0;

    //print(a);
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
                Padding(
                  padding: getPadding(
                    top: getVerticalSize(35),
                  ),
                ),
                //header

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colors,
                        ),
                        border: Border.all(color: circleColor),
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
                              percent: double.parse(marks != ''
                                      ? marks
                                      : widget.schoolClass.pctGrade!) /
                                  100,
                              center: Text(
                                "${marks != '' ? marks : widget.schoolClass.pctGrade}%",
                                style: TextStyle(
                                    fontFamily: "poppinsBold",
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: circleColor,
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
                            "${widget.schoolClass.period!}${ordinal(widget.schoolClass.period ?? 0)} Period",
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

                //sub heading
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //person name
                    Container(
                      height: 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colors,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(
                          width: 1.5,
                          color: circleColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.schoolClass.classTeacher ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                    //timeing
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colors,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(
                          width: 1.5,
                          color: circleColor,
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
                            width: 10,
                          ),
                          Text('9:00AM - 10:00 AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Assignments",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: Builder(builder: (context) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.schoolClass.assignments!.length,
                      itemBuilder: (context, index) {
                        var assignments =
                            widget.schoolClass.assignments![index];
                        if (assignments.earnedPoints! < 0) {
                          return SizedBox();
                        }

                        return SwipeActionCell(
                          backgroundColor: Colors.transparent,
                          key: ObjectKey('1'),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                widthSpace: 60,
                                backgroundRadius: 12,
                                icon: Icon(Icons.delete),
                                onTap: (CompletionHandler handler) async {
                                  print('You have tapped delete button');
                                },
                                color: Colors.red),
                          ],
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xff242424),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              onExpansionChanged: (value) {
                                //_marqueeActive = !_marqueeActive;
                                String? ifZero = '';
                                String? ifFull = '';
                                if (value == true) {
                                  ifZero = getBoost(
                                    'Zero',
                                    assignments.earnedPoints!,
                                    assignments.possiblePoints!,
                                    assignments.category!,
                                    widget.schoolClass.assignmentCategories!,
                                    assignments.category!,
                                  );
                                  print('ifZero: $ifZero');
                                  ifFull = getBoost(
                                    'Full',
                                    assignments.earnedPoints!,
                                    assignments.possiblePoints!,
                                    assignments.category!,
                                    widget.schoolClass.assignmentCategories!,
                                    assignments.category!,
                                  );

                                  print('ifFull: $ifFull');
                                }
                                if (value == true) {
                                  setState(() {
                                    //Getting boost percentage
                                    boostPct =
                                        pctIncrease(ifZero, ifFull)!.toInt();
                                    print('boostPct: $boostPct');
                                    //ERROR IS HERE : boostPct is not being updated in the UI
                                  });
                                }
                              },
                              trailing: SizedBox(
                                width: 0,
                                height: 0,
                              ),
                              title: Container(
                                height: 84,
                                margin: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          assignments.assignmentName ??
                                              'Assignment Name',
                                          // "MP4 FA11.3 Le Chatelier's Principle Quick Quiz",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 24,
                                          width: 74,
                                          margin: EdgeInsets.only(left: 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0xff3A312A)
                                                  .withOpacity(1),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            'All Tasks',
                                            style: TextStyle(
                                                color: Color(0xffFFA656),
                                                fontSize: 14),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var controller =
                                                TextEditingController();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Add expected outcome of this assignment',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  content: TextFormField(
                                                    cursorColor: Colors.white,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: controller,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (controller.text
                                                                  .isEmpty ||
                                                              double.parse(
                                                                      controller
                                                                          .text) >
                                                                  assignments
                                                                      .earnedPoints!) {
                                                            Navigator.pop(
                                                                context);
                                                            return;
                                                          }
                                                          // print(
                                                          //     'CONTROLLER TEXT: ${controller.text}');
                                                          // print(
                                                          //     'EARNED POINTS: ${assignments.earnedPoints}');
                                                          // print(
                                                          //     'TOTAL POINTS: ${assignments.possiblePoints}');

                                                          marks =
                                                              gradeChangeAlgo(
                                                            controller.text,
                                                            assignments
                                                                .earnedPoints!,
                                                            assignments
                                                                .possiblePoints!,
                                                            assignments
                                                                .category!,
                                                            widget.schoolClass
                                                                .assignmentCategories!,
                                                            assignments
                                                                .category!,
                                                          );

                                                          setState(() {
                                                            assignments
                                                                    .earnedPoints =
                                                                double.parse(
                                                                    controller
                                                                        .text);

                                                            colors = gradeUtils
                                                                .getColors();
                                                            circleColor = gradeUtils
                                                                .getCircleColor();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Add',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            assignments.earnedPoints == null
                                                ? 'N/A'
                                                : '${assignments.earnedPoints!}/${assignments.possiblePoints!}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xff242424),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 33,
                                            width: 128,
                                            decoration: BoxDecoration(
                                                color: Color(0xff171717),
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 33,
                                                  width: 33,
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: SvgPicture.asset(
                                                    'assets/images/suit_case.svg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '5/2/21 11:59PM',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 33,
                                            width: 128,
                                            decoration: BoxDecoration(
                                                color: Color(0xff171717),
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 33,
                                                  width: 33,
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: SvgPicture.asset(
                                                    'assets/images/lock.svg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '5/2/21 1:59PM',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 33,
                                            width: 128,
                                            decoration: BoxDecoration(
                                                color: Color(0xff171717),
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: getVerticalSize(33),
                                                  width: getHorizontalSize(33),
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: SvgPicture.asset(
                                                    'assets/images/order.svg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getHorizontalSize(5),
                                                ),
                                                Text(
                                                  '$boostPct% Boost.',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: getHorizontalSize(5),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'A 100% on this assignment will give you a $boostPct% boost.', // message
                                                      toastLength: Toast
                                                          .LENGTH_SHORT, // length
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      // location
                                                    );
                                                  },
                                                  child: Icon(Icons.info,
                                                      color: Colors.white,
                                                      size: 18),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            width: 128,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                )),
              ],
            )),
      ),
    );
  }
}
