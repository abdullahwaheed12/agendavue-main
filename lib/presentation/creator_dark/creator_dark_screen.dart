// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../settings_dark_screen/settings_dark_screen.dart';
import '../signin_dark_screen/signin_dark_screen.dart';

class CreatorDarkScreen extends StatelessWidget {
  const CreatorDarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.darkModeBkg,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
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
                              'Creator',
                              style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(18.0),
                                color: ColorConstant.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
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
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            ImageConstant.creatorPic),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle),
                                  // child: Image.memory(
                                  //   image,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
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
                                                    text: '12',
                                                    style: GoogleFonts.poppins(
                                                        fontSize:
                                                            getVerticalSize(15),
                                                        color: ColorConstant
                                                            .white),
                                                  ),
                                                  TextSpan(
                                                    text: 'th',
                                                    style: GoogleFonts.poppins(
                                                        fontSize:
                                                            getVerticalSize(11),
                                                        color: ColorConstant
                                                            .white),
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
                        // SizedBox(
                        //   height: 140,
                        //   width: 140,
                        //   child: Stack(
                        //     clipBehavior: Clip.none,
                        //     fit: StackFit.expand,
                        //     children: [
                        //       CircleAvatar(
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 67,
                        //           backgroundImage: AssetImage(
                        //             ImageConstant.sciBgkd,
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //           bottom: 0,
                        //           right: -25,
                        //           child: RawMaterialButton(
                        //             onPressed: () {},
                        //             // elevation: 2.0,
                        //             fillColor: Color(0xFF121212),
                        //             child: Row(
                        //               children: [
                        //                 Text(
                        //                   "12",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.w600),
                        //                 ),
                        //                 SizedBox(width: 0.5),
                        //                 Padding(
                        //                   padding: EdgeInsets.only(top: 08),
                        //                   child: Text(
                        //                     "th",
                        //                     style: TextStyle(
                        //                         fontSize: 08,
                        //                         color: Colors.white),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             padding: EdgeInsets.all(15.0),
                        //             shape: CircleBorder(
                        //               side: BorderSide(
                        //                 width: 2,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //           )),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Bisrat Tadesse",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(22.0),
                                letterSpacing: 0.5,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Wheaton Highschool",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(18.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 360,
                          // height: 220,
                          decoration: BoxDecoration(
                            color: Color(0xFF242424),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xFF242424),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Originally meant for an app competition, this project has took about a month to complete. I've decided to release it to the public, along with many updates coming soon.",
                                  style: AppStyle.poppinsRegural.copyWith(
                                    fontSize: getFontSize(16.0),
                                    color: ColorConstant.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Contact Me",
                            style: AppStyle.poppinsRegural.copyWith(
                                fontSize: getFontSize(22.0),
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w600),
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
                                String textToCopy = "dev.bizzy@gmail.com";
                                Clipboard.setData(
                                        new ClipboardData(text: textToCopy))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Email copied to Clipboard!')));
                                });
                                // final Uri url = Uri.parse(
                                //     'https://mail.google.com/mail/?view=cm&source=mailto&to=[dev.bizzy@gmail.com]');
                                // if (!await launchUrl(url)) {
                                //   throw 'Could not launch $url';
                                // }
                              },
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                            tileColor: Color(0xFF242424),
                            title: Text(
                              "Gmail",
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
                                final Uri url = Uri.parse(
                                    'https://www.instagram.com/bxzzyy/');
                                if (!await launchUrl(url)) {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            )),
                            tileColor: Color(0xFF242424),
                            title: Text(
                              "Instagram",
                              style: AppStyle.poppinsRegural.copyWith(
                                  fontSize: getFontSize(16.0),
                                  color: ColorConstant.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
