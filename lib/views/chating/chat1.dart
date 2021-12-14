// import 'package:flutter_chat/chatData.dart';
import 'package:carpooling_app/views/chatscreen.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_chat/chatWidget.dart';

class Chat1 extends StatefulWidget {
  const Chat1({Key? key}) : super(key: key);

  @override
  State<Chat1> createState() => _Chat1State();
}

class _Chat1State extends State<Chat1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            chatItem("Ali Hassan", "Hi! i want to join you in the ride",
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            chatItem(
              "Uzair Iqbal",
              "Hi! i want to join you in the ride",
              "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
            ),
            chatItem("Muhammad Ibrar", "Hi! i want to join you in the ride",
                "https://bucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com/public/images/f04b52da-12f2-449f-b90c-5e4d5e2b1469_361x361.png"),
            chatItem("Hassain Haider", "Hi! i want to join you in the ride",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU"),
          ],
        ),
      ),
    );
  }

  InkWell chatItem(String name, String message, String img) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatPage(
              name: name,
            ));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                img,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: name,
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // Icon(Icons.location_pin),
                    Container(
                      width: Get.width / 1.5,
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Spacer(),
            // Icon(Icons.message, size: 35)
          ],
        ),
      ),
    );
  }
}
