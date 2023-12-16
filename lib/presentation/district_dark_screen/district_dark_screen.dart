import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../signin_dark_screen/signin_dark_screen.dart';
import 'controller/district_dark_controller.dart';

class DistrictDarkScreen extends StatefulWidget {
  DistrictDarkScreen({Key? key}) : super(key: key);
  @override
  State<DistrictDarkScreen> createState() => _DistrictDarkScreenState();
}

class _DistrictDarkScreenState extends State<DistrictDarkScreen> {
  String searchString = "";
  var searchController = TextEditingController();
  var focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistrictDarkController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.darkModeBkg,
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(40),
                  bottom: getVerticalSize(10),
                ),
                child: Text(
                  "First, let's find your school district",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'DM Sans',
                    color: ColorConstant.white,
                    fontSize: getFontSize(20),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
                        child: TextField(
                          focusNode: focus,
                          controller: searchController,
                          // onChanged: (value) {
                          //   searchString = value.toLowerCase();
                          //   controller.updateText(searchString);
                          // },
                          textInputAction: TextInputAction.search,
                          onTap: () {
                            print('onTap called ');
                          },
                          onEditingComplete: () {
                            print('onEditingComplete called ');
                          },
                          onSubmitted: (value) {
                            print("search");
                            FocusScope.of(context).unfocus();

                            controller.getDistrictDataFromZipCode(
                                searchController.text);
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
                            hintText: "Enter your zipcode",
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
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();

                                  controller.getDistrictDataFromZipCode(
                                      searchController.text);
                                },
                                child: Icon(
                                  Icons.search,
                                  color: ColorConstant.white,
                                ),
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
              Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(20),
                ),
                child: Divider(
                  color: ColorConstant.grey,
                  thickness: getHorizontalSize(0.8),
                ),
              ),
              Expanded(
                flex: 1,
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : controller.listOfZipCodeResult == null
                        ? Center(
                            child: Padding(
                              padding: getPadding(
                                bottom: getVerticalSize(200),
                              ),
                              child: Text(
                                'Enter your zipcode',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(18),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: ListView.separated(
                              padding: getPadding(
                                right: getHorizontalSize(6),
                                left: getHorizontalSize(6),
                              ),
                              itemCount: controller.listOfZipCodeResult!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var studentData =
                                    controller.listOfZipCodeResult![index];
                                print('---->>>> ${studentData.districtUrl}');
                                return studentData.districtName!
                                        .toLowerCase()
                                        .contains(searchString)
                                    ? ListTile(
                                        title: Text(
                                          '${studentData.districtName}',
                                          style: TextStyle(
                                              color: ColorConstant.white),
                                        ),
                                        subtitle: Text(
                                          '${studentData.address}',
                                          style: TextStyle(
                                              color: ColorConstant.white),
                                        ),
                                        onTap: () {
                                          GetStorage().write(districtSchoolKey,
                                              studentData.districtName);
                                          GetStorage().write(
                                              districtDomainUrlKey,
                                              studentData.districtUrl);
                                          Get.to(
                                            SigninDarkScreen(isFromLogin: true),
                                          );
                                        },
                                      )
                                    : Container();
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return controller.listOfZipCodeResult![index]
                                        .districtName!
                                        .toLowerCase()
                                        .contains(searchString)
                                    ? Divider(
                                        color: ColorConstant.white,
                                        thickness: getHorizontalSize(0.5),
                                        indent: getHorizontalSize(10),
                                        endIndent: getHorizontalSize(10),
                                      )
                                    : Container();
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
