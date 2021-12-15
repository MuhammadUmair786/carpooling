import 'package:carpooling_app/views/drawer/addCash.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Balance"),
        elevation: 0,
        backgroundColor: Color(0xFFF4793E),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width / 1.2,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF4793E),
                ),
                child: Column(
                  children: [
                    CustomText(text: "Account Balance",weight: FontWeight.bold,color: Colors.white,),
                    Container(
                      width: Get.width / 2,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: CustomText(
                          text: "Rs. 2344",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => AddCash());
                          },
                          child: Text(
                            "Add Cash",
                            style: TextStyle(
                              color: Color(0xFFF4793E)
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    CustomText(text: "Pending Clearence"),
                    pendingItem(),
                    pendingItem(),
                    pendingItem(),
                    pendingItem(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container pendingItem() {
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
                text: "Ride Id # 352334645",
                size: 14,
                weight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              CustomText(
                text: "24 Aug, 2021",
                size: 14,
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

          // Container(
          //   color: Colors.grey,
          //   height: 0.5,
          //   margin: EdgeInsets.symmetric(vertical: 8),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Rs. 235",
                size: 22,
                weight: FontWeight.bold,
              ),
              CustomText(
                text: "cleared on 26 Aug",
                size: 14,
                // weight: FontWeight.bold,
                color: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
