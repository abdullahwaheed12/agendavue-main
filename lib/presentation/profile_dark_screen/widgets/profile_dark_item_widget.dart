import 'package:get/get.dart';

import '../controller/profile_dark_controller.dart';
import '../models/profile_dark_item_model.dart';
import '../../../core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileDarkItemWidget extends StatelessWidget {
  ProfileDarkItemWidget(this.profileDarkItemModelObj);

  ProfileDarkItemModel profileDarkItemModelObj;

  var controller = Get.find<ProfileDarkController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getVerticalSize(
          6,
        ),
        bottom: getVerticalSize(
          6,
        ),
      ),
      child: Stack(
        children: [
          Image.asset(
            ImageConstant.homeFilledIcon,
            height: getHorizontalSize(
              121,
            ),
            width: getHorizontalSize(
              343,
            ),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getHorizontalSize(
                15,
              ),
              top: getVerticalSize(
                15,
              ),
              right: getHorizontalSize(
                156,
              ),
              bottom: getVerticalSize(
                14,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "lbl_topic".tr,
                  textAlign: TextAlign.left,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(
                      10,
                    ),
                  ),
                ),
                Text(
                  "msg_music_technolog".tr,
                  textAlign: TextAlign.left,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(
                      17,
                    ),
                  ),
                ),
                Text(
                  "lbl_3rd_period".tr,
                  textAlign: TextAlign.left,
                  style: AppStyle.poppinsRegural.copyWith(
                    fontSize: getFontSize(
                      10,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: getVerticalSize(
                      8,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.grey,
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        16,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  28,
                                ),
                                top: getVerticalSize(
                                  8,
                                ),
                                bottom: getVerticalSize(
                                  8,
                                ),
                              ),
                              child: Text(
                                "lbl_87".tr,
                                textAlign: TextAlign.center,
                                style: AppStyle.poppinsRegural.copyWith(
                                  fontSize: getFontSize(
                                    10,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: getHorizontalSize(
                                  28,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    16.0,
                                  ),
                                ),
                                child: Image.asset(
                                  ImageConstant.socialSciIcon,
                                  height: getHorizontalSize(
                                    32,
                                  ),
                                  width: getHorizontalSize(
                                    32,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
