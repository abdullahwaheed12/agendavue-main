import 'package:agendavue/controllers/general_controller.dart';
import 'package:agendavue/data/apiClient/studentApiCall.dart';
import 'package:agendavue/data/models/class_schedule.dart';
import 'package:agendavue/presentation/complete_work_screen/complete_work_screen.dart';
import 'package:agendavue/presentation/notifications_dark_screen/notifications_dark_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import '../../data/models/todo.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime today = DateTime.now();
  final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  final DateFormat format1 = DateFormat('MMM');
  final DateFormat format2 = DateFormat('dd');
  //random title
  Widget getTitle(int index) {
    if (index % 2 == 0) {
      return Container(
        height: 24,
        width: 74,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffFFA656).withOpacity(0.2),
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          'All Tasks',
          style: TextStyle(color: Color(0xffFFA656), fontSize: 14),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff3E3E3E).withOpacity(0.5),
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          'Homework',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      );
    }
  }

//random icon
  Widget getIcon(String categoryName) {
    Map map = GetStorage().read(districtSchoolKey);
    var category = map[categoryName];
    if (category == 'Science') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/science.png'),
      );
    } else if (category == 'Social Studies') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/Social_Studies.png'),
      );
    } else if (category == 'Computers') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/computer.png'),
      );
    } else if (category == 'Arts') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/art.png'),
      );
    } else if (category == 'Language') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/language.png'),
      );
    } else if (category == 'Math') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/math.png'),
      );
    } else if (category == 'Sports') {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/spotrs.png'),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 10),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D9CDB),
        ),
        child: Image.asset('assets/images/other.png'),
      );
    }
  }

  SwipeActionController controller = SwipeActionController();
  ScrollController todayController = ScrollController();
  ScrollController tomorowController = ScrollController();
  var instance = Get.find<GeneralController>();
  ClassInfo? classInfo;
  void getLiveClass() {
    classInfo = null;
    var today = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
    for (var element in instance.classInfo!) {
      if (element.endDate == null || element.startDate == null) continue;

      var startDate = DateFormat('MM/dd/yyyy HH:mm:').parse(element.startDate!);
      if (element.startDate!.contains('PM')) {
        startDate = startDate.add(Duration(hours: 12));
      }
      var endDate = DateFormat('MM/dd/yyyy HH:mm:').parse(element.endDate!);
      if (element.endDate!.contains('PM')) {
        endDate = endDate.add(Duration(hours: 12));
      }

      if (today.isBefore(startDate) && today.isAfter(endDate)) {
        // print('start time $startDate');
        // print('end time $endDate');
        classInfo = element;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (instance.classInfo != null) {
      getLiveClass();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: getPadding(top: getVerticalSize(14), left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                // appbar
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteWorkScreen(),
                              ));
                        },
                        child: Container(
                          width: getHorizontalSize(28),
                          height: getVerticalSize(30),
                          child: SvgPicture.asset(
                            ImageConstant.tasksIcon,
                            color: ColorConstant.white,
                          ),
                        ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotificationsAnnoucmentsScreen(),
                              ));
                        },
                        child: Container(
                          width: getHorizontalSize(28),
                          height: getVerticalSize(30),
                          child: SvgPicture.asset(
                            ImageConstant.notificationIcon,
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
                //2
                Builder(builder: (context) {
                  if (DateTime.now().weekday == 6 ||
                      DateTime.now().weekday == 7 ||
                      classInfo == null) {
                    return Center(
                        child: Image.asset('assets/images/no_class.png'));
                  }

                  return Container(
                    height: 120,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage('assets/chemistry.png'),
                            fit: BoxFit.fill)),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(builder: (context) {
                              var a = classInfo!.className!.split(' ');
                              print('ddd $a');
                              var b = a[1] + a[2];
                              return Text(
                                classInfo?.className != null ? b : 'Empty',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(22),
                                  color: ColorConstant.white,
                                ),
                              );
                            }),
                            Padding(
                              padding: getPadding(
                                top: getVerticalSize(5),
                              ),
                            ),
                            Text(
                              "Room: ${classInfo?.roomName}",
                              style: TextStyle(
                                color: Color(0xffbfb8b8),
                                fontSize: getFontSize(16),
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: getVerticalSize(2),
                              ),
                            ),
                            Text(
                              "Period: ${classInfo?.period}",
                              style: TextStyle(
                                color: Color(0xffbfb8b8),
                                fontSize: getFontSize(16),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: getPadding(
                            bottom: getVerticalSize(40),
                            left: getHorizontalSize(0),

                            // right: getHorizontalSize(5),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            padding: getPadding(
                              left: getHorizontalSize(5),
                              right: getHorizontalSize(5),
                              top: getHorizontalSize(5),
                              bottom: getHorizontalSize(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: getHorizontalSize(8),
                                  height: getVerticalSize(8),
                                  margin: getMargin(
                                    top: getVerticalSize(5),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffff0000),
                                  ),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(3),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(30),
                                  height: getVerticalSize(12),
                                  child: Text(
                                    "Live",
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w600,
                                      fontSize: getFontSize(14),
                                      color: ColorConstant.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: getPadding(
                    top: getVerticalSize(35),
                  ),
                ),
                //3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Today",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: getFontSize(25),
                        color: ColorConstant.white,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: getHorizontalSize(190),
                      ),
                    ),
                    Text(
                      format1.format(today) +
                          " " +
                          DateTime.now().day.toString(),
                      // DateTime.now().toString().substring(0, 10),
                      style: AppStyle.poppinsRegural.copyWith(
                        fontSize: getFontSize(18),
                        color: ColorConstant.white,
                      ),
                    ),
                  ],
                ),
                //today
                if (StudentApiCall.todoData != null &&
                    StudentApiCall.todoData!.isNotEmpty)
                  Builder(builder: (context) {
                    List<Todo>? todoData = [];
                    StudentApiCall.missing = [];
                    for (var e in StudentApiCall.todoData!) {
                      var date = e.assignment.dueAt;
                      // print('data $date');

                      if (DateTime.now().day == date.day) {
                        todoData.add(e);
                      } else if (DateTime.now().isBefore(date)) {
                        StudentApiCall.missing.add(e);
                      } else if (DateTime.now().isAfter(date)) {}
                    }
                    if (todoData.isEmpty) {
                      return Center(
                        child: Text(
                          'No Assignment Today!',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: ListView.builder(
                          controller: todayController,
                          itemCount: todoData.length,
                          itemBuilder: (context, index) {
                            var assignment = todoData[index];
                            // print(
                            //     '-->>>>> contextName ${assignment.contextName}');

                            return SwipeActionCell(
                              controller: controller,
                              backgroundColor: Colors.transparent,
                              key: ObjectKey('1'),
                              trailingActions: <SwipeAction>[
                                SwipeAction(
                                    widthSpace: 60,
                                    backgroundRadius: 12,
                                    icon: Icon(Icons.delete),
                                    onTap: (CompletionHandler handler) async {
                                      StudentApiCall.todoData
                                          ?.remove(assignment);
                                      StudentApiCall.complete.add(assignment);
                                      controller.closeAllOpenCell();
                                      setState(
                                        () {},
                                      );
                                    },
                                    color: Colors.red),
                              ],
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xff242424),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.zero,
                                  trailing: SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),
                                  title: Container(
                                    height: 80,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.only(top: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getIcon(assignment.contextName),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              assignment.assignment.name
                                                          .length <
                                                      27
                                                  ? assignment.assignment.name
                                                  : '${assignment.assignment.name.substring(0, 26)}...',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            getTitle(index),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, left: 10, bottom: 40),
                                          child: Text(
                                            assignment.assignment.pointsPossible
                                                    .toString() +
                                                " " +
                                                "Pts",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        )
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
                                                width: 138,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/suit_case.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${assignment.assignment.dueAt.year}/${assignment.assignment.dueAt.month}/${assignment.assignment.dueAt.day} ${assignment.assignment.dueAt.toString().substring(10, 16)}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 33,
                                                width: 138,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/lock.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      assignment.assignment
                                                                  .lockAt ==
                                                              null
                                                          ? 'Empty '
                                                          : '${assignment.assignment.lockAt!.year}/${assignment.assignment.lockAt!.month}/${assignment.assignment.lockAt!.day} ${assignment.assignment.lockAt.toString().substring(10, 16)}',
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
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/order.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '5.6% Boost',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Boost up', // message
                                                          toastLength: Toast
                                                              .LENGTH_SHORT, // length
                                                          gravity: ToastGravity
                                                              .CENTER,
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
                                              Container(
                                                height: 33,
                                                width: 128,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/bell.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'In 3 Hours?',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final Event event =
                                                            Event(
                                                          title: 'Event title',
                                                          description:
                                                              'Event description',
                                                          location:
                                                              'Event location',
                                                          startDate:
                                                              DateTime.now(),
                                                          endDate:
                                                              DateTime.now()
                                                                  .add(Duration(
                                                                      hours:
                                                                          3)),
                                                          iosParams: IOSParams(
                                                            reminder: Duration(
                                                                /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                                                          ),
                                                          androidParams:
                                                              AndroidParams(
                                                            emailInvites: [], // on Android, you can add invite emails to your event.
                                                          ),
                                                        );

                                                        var isSet =
                                                            await Add2Calendar
                                                                .addEvent2Cal(
                                                                    event);
                                                        debugPrint(
                                                            'is set $isSet');
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              '3 hours remaining', // message
                                                          toastLength: Toast
                                                              .LENGTH_SHORT, // length
                                                          gravity: ToastGravity
                                                              .CENTER,
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
                        ),
                      ),
                    );
                  })
                else
                  Center(
                    child: Text(
                      "No Assignments Today!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                //title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tomorrow",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: getFontSize(25),
                          color: ColorConstant.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        format1.format(today) + " " + format2.format(tomorrow),
                        style: AppStyle.poppinsRegural.copyWith(
                          fontSize: getFontSize(18),
                          color: ColorConstant.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //tomorrow
                if (StudentApiCall.todoData != null)
                  SizedBox(
                      height: 400,
                      child: Builder(builder: (context) {
                        return ListView.builder(
                          controller: tomorowController,
                          itemCount:
                              StudentApiCall.studentUpCommingEventModel!.length,
                          itemBuilder: (context, index) {
                            var assignment = StudentApiCall
                                .studentUpCommingEventModel![index];

                            return SwipeActionCell(
                              controller: controller,
                              backgroundColor: Colors.transparent,
                              key: ObjectKey('1'),
                              trailingActions: <SwipeAction>[
                                SwipeAction(
                                    widthSpace: 60,
                                    backgroundRadius: 12,
                                    // title: "delete",
                                    icon: Icon(Icons.delete),
                                    onTap: (CompletionHandler handler) async {
                                      controller.closeAllOpenCell();
                                      setState(
                                        () {},
                                      );
                                    },
                                    color: Colors.red),
                              ],
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xff242424),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.zero,
                                  trailing: SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),
                                  title: Container(
                                    height: 80,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.only(top: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getIcon(assignment.contextName ?? ''),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              assignment.assignment.name
                                                          .length <
                                                      27
                                                  ? assignment.assignment.name
                                                  : '${assignment.assignment.name.substring(0, 26)}...',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            getTitle(index),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, bottom: 40),
                                          child: Text(
                                            assignment.assignment.pointsPossible
                                                    .toString() +
                                                " " +
                                                "Pts",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        )
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
                                                width: 138,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/suit_case.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${assignment.assignment.dueAt.year}/${assignment.assignment.dueAt.month}/${assignment.assignment.dueAt.day} ${assignment.assignment.dueAt.toString().substring(10, 16)}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 33,
                                                width: 138,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/lock.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      assignment.assignment
                                                                  .lockAt ==
                                                              null
                                                          ? 'Empty '
                                                          : '${assignment.assignment.lockAt!.year}/${assignment.assignment.lockAt!.month}/${assignment.assignment.lockAt!.day} ${assignment.assignment.lockAt.toString().substring(10, 16)}',
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
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/order.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '5.6% Boost',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Boost up', // message
                                                          toastLength: Toast
                                                              .LENGTH_SHORT, // length
                                                          gravity: ToastGravity
                                                              .CENTER,
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
                                              Container(
                                                height: 33,
                                                width: 128,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff171717),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: SvgPicture.asset(
                                                        'assets/images/bell.svg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'In 3 Hours?',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final Event event =
                                                            Event(
                                                          title: 'Event title',
                                                          description:
                                                              'Event description',
                                                          location:
                                                              'Event location',
                                                          startDate:
                                                              DateTime.now(),
                                                          endDate:
                                                              DateTime.now()
                                                                  .add(Duration(
                                                                      hours:
                                                                          3)),
                                                          iosParams: IOSParams(
                                                            reminder: Duration(
                                                                /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                                                          ),
                                                          androidParams:
                                                              AndroidParams(
                                                            emailInvites: [], // on Android, you can add invite emails to your event.
                                                          ),
                                                        );

                                                        var isSet =
                                                            await Add2Calendar
                                                                .addEvent2Cal(
                                                                    event);
                                                        debugPrint(
                                                            'is set $isSet');
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              '3 hours remaining', // message
                                                          toastLength: Toast
                                                              .LENGTH_SHORT, // length
                                                          gravity: ToastGravity
                                                              .CENTER,
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
                      })),

                Padding(
                  padding: getPadding(
                    top: getVerticalSize(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
