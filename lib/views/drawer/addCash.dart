import 'package:carpooling_app/views/Payment/paymentHomeScreen.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cash"),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addCashItem(Icons.account_balance, "Through Bank", () {
                  // Get.to(() =>
                }),
                addCashItem(Icons.e_mobiledata, "Through EasyPaisa", () {
                  // Get.to(() => NotificationSetting());
                }),
                addCashItem(Icons.format_align_justify, "Through JazzCash", () {
                  // Get.to(() => Privacy());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell addCashItem(IconData icon, String title, Function() fun) {
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
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
