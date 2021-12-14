
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("History"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 15),
                historyItem(),
                historyItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container historyItem() {
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Id # 3523346245745",
                size: 15,
                weight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              CustomText(
                text: "24 Aug, 2021",
                size: 15,
                weight: FontWeight.bold,
                color: Colors.purple,
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  startEndItem(Icons.trip_origin, "Faisal Colony"),
                  SizedBox(height: 5),
                  startEndItem(Icons.location_on, "Comsats University"),
                ],
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
              )
            ],
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Pending"),
              CustomText(
                text: "Rs. 230",
                size: 20,
                weight: FontWeight.bold,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row startEndItem(IconData ic, String locationName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(ic),
        SizedBox(width: 5),
        Container(
          alignment: Alignment.topLeft,
          width: Get.width / 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: locationName,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
