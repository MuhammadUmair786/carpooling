import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4793E),
        elevation: 0,
        title: Text("Notifications"),
        // leading: Icon(Icons.add_business),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextButton(
              onPressed: () {},
              child: Text("Mark As Read",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 20),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  Widget notificationItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.3),
          ),
        ),
        // color: Colors.teal,
        // height: 72,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80"),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width / 1.4,
                  child: Text(
                    "Ride Accepted by Muhammad Uzair",
                    textScaleFactor: 1.3,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                CustomText(
                  text: "1 day ago",
                  size: 11,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
