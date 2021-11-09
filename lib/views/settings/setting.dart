import 'package:carpooling_app/views/login.dart';

import 'package:carpooling_app/views/settings/appereance.dart';
import 'package:carpooling_app/views/settings/notificationsetting.dart';
import 'package:carpooling_app/views/settings/privacy.dart';
import 'package:carpooling_app/views/settings/profile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingItem(Icons.account_circle, "Profile", () {
                  Get.to(() => ProfileSetting());
                }),
                settingItem(Icons.notifications, "Notifications", () {
                  Get.to(() => NotificationSetting());
                }),
                settingItem(Icons.privacy_tip, "Privacy", () {
                  Get.to(() => Privacy());
                }),
                settingItem(Icons.app_settings_alt_rounded, "Appearence", () {
                  Get.to(() => Appearence());
                }),
                InkWell(
                  onTap: () async {
                    showLoading();

                    await FirebaseAuth.instance.signOut().whenComplete(() {
                      Get.offAll(() => Login());
                      Get.reset();
                    });
                    dismissLoadingWidget();
                  },
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 35,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        CustomText(
                          text: "Logout",
                          weight: FontWeight.w400,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell settingItem(IconData icon, String title, Function() fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 35,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            SizedBox(width: 15),
            CustomText(
              text: title,
              weight: FontWeight.w400,
              size: 22,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
