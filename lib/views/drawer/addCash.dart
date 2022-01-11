import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AddCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Cash"),
          elevation: 0,
          backgroundColor: Color(0xFFF4793E)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addCashItem(Icons.account_balance, "Through Bank", () {
                  // Get.to(() => ProfileSetting());
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Material(
          // padding: EdgeInsets.symmetric(horizontal: 15),
          color: Color(0xFFF4793E),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(width: 15),
                CustomText(
                  text: title,
                  weight: FontWeight.w400,
                  size: 16,
                  color: Colors.white,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// hbjk