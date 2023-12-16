import 'package:agendavue/data/apiClient/studentApiCall.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class NotificationsAnnoucmentsScreen extends StatefulWidget {
  const NotificationsAnnoucmentsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsAnnoucmentsScreen> createState() =>
      _NotificationsAnnoucmentsScreenState();
}

class _NotificationsAnnoucmentsScreenState
    extends State<NotificationsAnnoucmentsScreen> {
  final List<String> items = [
    'Announcements',
  ];
  String? selectedValue;
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
                  top: getVerticalSize(20),
                ),
              ),
              //announcemnet title
              Center(
                child: categories(),
              ),
              //announcement body
              Expanded(child: Builder(builder: (context) {
                if (StudentApiCall.studentAnnouncemnet == null) {
                  //print('error');
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: StudentApiCall.studentAnnouncemnet!.length,
                  itemBuilder: (context, index) {
                    var announment = StudentApiCall.studentAnnouncemnet![index];
                    String createdAt = announment['created_at'];
                    var date = DateTime.parse(createdAt);
                    String title = announment['title'];
                    String? url = announment['url'];
                    return Container(
                      // alignment: Alignment.center,
                      // height: 140,
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/notification_bg.png",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${date.year}/${date.month}/${date.day}',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFBEBEBE)),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final Uri url1 = Uri.parse(url ?? '');
                                    if (!await launchUrl(url1)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(08),
                                    ),
                                    child: Center(
                                        child: Icon(Icons.open_in_new_sharp)),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                );
              })),
            ],
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
          alignment: Alignment.center,
          height: getVerticalSize(44),
          width: getHorizontalSize(160),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white)),
          child: Text(
            'Announcements',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
