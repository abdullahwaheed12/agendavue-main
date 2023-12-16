import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:agendavue/presentation/complete_work_screen/complete_work_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/apiClient/studentApiCall.dart';
import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class MissingWorkScreen extends StatefulWidget {
  const MissingWorkScreen({Key? key}) : super(key: key);

  @override
  State<MissingWorkScreen> createState() => _MissingWorkScreenState();
}

class _MissingWorkScreenState extends State<MissingWorkScreen> {
  final List<String> items = [
    'Complete Work',
  ];
  String? selectedValue;
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
          style: TextStyle(color: Color(0xffFFA656)),
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
          style: TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.darkModeBkg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: getPadding(
            top: getVerticalSize(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
                Center(
                  child: categories(),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: StudentApiCall.missing.length,
                  itemBuilder: (context, index) {
                    var assignment = StudentApiCall.missing[index];
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
                              StudentApiCall.missing.remove(assignment);
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
                            padding: EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getIcon(assignment.contextName),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      assignment.assignment.name.length < 27
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
                                Text(
                                  assignment.assignment.pointsPossible
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
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
                                              assignment.assignment.lockAt ==
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
                                                  msg: 'Boost up', // message
                                                  toastLength: Toast
                                                      .LENGTH_SHORT, // length
                                                  gravity: ToastGravity.CENTER,
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
                                                final Event event = Event(
                                                  title: 'Event title',
                                                  description:
                                                      'Event description',
                                                  location: 'Event location',
                                                  startDate: DateTime.now(),
                                                  endDate: DateTime.now()
                                                      .add(Duration(hours: 3)),
                                                  iosParams: IOSParams(
                                                    reminder: Duration(
                                                        /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                                                  ),
                                                  androidParams: AndroidParams(
                                                    emailInvites: [], // on Android, you can add invite emails to your event.
                                                  ),
                                                );

                                                var isSet = await Add2Calendar
                                                    .addEvent2Cal(event);
                                                debugPrint('is set $isSet');
                                                Fluttertoast.showToast(
                                                  msg:
                                                      '3 hours remaining', // message
                                                  toastLength: Toast
                                                      .LENGTH_SHORT, // length
                                                  gravity: ToastGravity.CENTER,
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
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row categories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: getVerticalSize(44),
          width: getHorizontalSize(120),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  Text(
                    'Missing',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                if ('Complete Work' == value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompleteWorkScreen(),
                      ));
                }
                // setState(() {
                //   selectedValue = value as String;
                // });
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
