// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agendavue/controllers/general_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import '../loading_dark_screen/loading_dark_screen.dart';

// ignore: must_be_immutable
class SigninDarkScreen extends StatefulWidget {
  final bool isFromLogin;
  const SigninDarkScreen({
    Key? key,
    this.isFromLogin = false,
  }) : super(key: key);

  @override
  State<SigninDarkScreen> createState() => _SigninDarkScreenState();
}

class _SigninDarkScreenState extends State<SigninDarkScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  bool termsofusecheckbox = false;
  bool remembermecheckbox = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;
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
                  top: getVerticalSize(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.isFromLogin) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: getHorizontalSize(52),
                          height: getVerticalSize(55),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: ColorConstant.darkModeButtons,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorConstant.white,
                            size: getVerticalSize(30),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Container(
                padding: getPadding(
                  top: getVerticalSize(40),
                  left: getHorizontalSize(30),
                ),
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.onBoardingTitle.copyWith(
                    letterSpacing: 1,
                    fontSize: getFontSize(35),
                  ),
                ),
              ),
              Container(
                padding: getPadding(
                  top: getVerticalSize(15),
                  left: getHorizontalSize(30),
                  right: getHorizontalSize(20),
                ),
                child: Text(
                  'Login with your school account to access your grades, assignments, and more.',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(16.2),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(20),
                ),
              ),
              Container(
                padding: getPadding(
                  left: getHorizontalSize(30),
                  right: getHorizontalSize(25),
                ),
                child: TextFormField(
                  cursorColor: Colors.white,
                  key: _formKey,
                  keyboardType: TextInputType.emailAddress,
                  controller: usernameController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Enter your school ID",
                    hintStyle: AppStyle.poppinsRegural.copyWith(
                      fontSize: getFontSize(15.0),
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.white,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: getPadding(
                        left: getHorizontalSize(10),
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        color: ColorConstant.white,
                        size: getHorizontalSize(20),
                      ),
                    ),
                    filled: true,
                    fillColor: ColorConstant.darkModeFormField,
                  ),
                  style: TextStyle(
                    fontSize: getFontSize(18.0),
                    color: ColorConstant.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(12),
                ),
              ),
              Container(
                padding: getPadding(
                  left: getHorizontalSize(30),
                  right: getHorizontalSize(25),
                ),
                child: TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  key: _formKey2,
                  keyboardType: TextInputType.visiblePassword,
                  // controller: controller.enteryourpassController,
                  obscureText: !isShowPassword,

                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        child: Padding(
                          padding: getPadding(
                            right: getHorizontalSize(15),
                          ),
                          child: Icon(
                            isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: getHorizontalSize(20),
                          ),
                        )),
                    alignLabelWithHint: true,
                    hintText: "Enter your password",
                    hintStyle: AppStyle.poppinsRegural.copyWith(
                      fontSize: getFontSize(15.0),
                      color: ColorConstant.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(15),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.white,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: getPadding(
                        left: getHorizontalSize(10),
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: ColorConstant.white,
                        size: getHorizontalSize(18),
                      ),
                    ),
                    filled: true,
                    fillColor: ColorConstant.darkModeFormField,
                  ),
                  style: TextStyle(
                    fontSize: getFontSize(18.0),
                    color: ColorConstant.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(2),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        side: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(04),
                        ),
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        value: remembermecheckbox,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            GetStorage().write(rememberMeForLoginKey, value);
                            remembermecheckbox = value!;
                          });
                        }),
                    Padding(
                      padding: getPadding(
                        left: getHorizontalSize(0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          //IMPORTANT THIS NEEDS TO BE THE FIRST LINE
                          remembermecheckbox =
                              remembermecheckbox ? false : true;
                          GetStorage().write(rememberMeForLoginKey,
                              remembermecheckbox ? false : true);
                          print(remembermecheckbox);
                        });
                      },
                      child: Text(
                        'Remember me',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.poppinsRegural.copyWith(
                          fontSize: getFontSize(16),
                          overflow: TextOverflow.ellipsis,
                          color: ColorConstant.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(15),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Fill all fields'),
                        ),
                      );
                      return;
                    }
                    try {
                      Get.find<GeneralController>().getStudentData(
                          usernameController.text,
                          passwordController.text,
                          GetStorage().read(districtDomainUrlKey) ?? '');

                      // if (remembermecheckbox) {
                      GetStorage().write(usernameKey, usernameController.text);
                      GetStorage().write(passwordKey, passwordController.text);
                      // }
                      Get.to(LoadingDarkScreen());
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Wrong ID or Password')));
                    }
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.poppinsBold.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: getFontSize(20),
                      color: ColorConstant.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.white,
                    alignment: Alignment.center,
                    minimumSize: Size(
                      getHorizontalSize(300),
                      getVerticalSize(60),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(20),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final Uri _url = Uri.parse(
                      '${GetStorage().read(districtDomainUrlKey)}/PXP2_Password_Help.aspx');

                  if (!await launchUrl(_url)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Couldn\'t open the link'),
                      ),
                    );
                    throw 'Couldn\'t launch $_url';
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.poppinsRegural.copyWith(
                      fontSize: getFontSize(17.0),
                      color: ColorConstant.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(30),
                ),
              ),
              Divider(
                color: ColorConstant.grey,
                thickness: getHorizontalSize(0.3),
              ),
              Padding(
                padding: getPadding(
                  top: getVerticalSize(20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Made for a student, by a student.",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(17.0),
                    color: ColorConstant.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
