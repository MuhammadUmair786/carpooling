import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        // height: Get.height,
        child: Column(
          children: [
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: NetworkImage(
            //               "https://i.dawn.com/primary/2019/03/5c9e6ab57ee44.png"),
            //           fit: BoxFit.cover)),
            // ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.width / 1.75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://i.dawn.com/primary/2019/03/5c9e6ab57ee44.png"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: "Our Mission",
                  weight: FontWeight.w500,
                  size: 35,
                  color: Colors.amber,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.done),
                      CustomText(
                        text: "Eco-Friendly",
                        weight: FontWeight.w500,
                        size: 20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.done),
                      CustomText(
                        text: "Reduce Traffic",
                        weight: FontWeight.w500,
                        size: 20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.done),
                      CustomText(
                        text: "Reduce Travel Expense",
                        weight: FontWeight.w500,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: "Surpervised by",
                  weight: FontWeight.w500,
                  size: 35,
                  color: Colors.amber,
                ),
              ],
            ),
            // CustomText(
            //   text: "Our Mission",
            //   weight: FontWeight.w500,
            //   size: 35,
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // CustomText(
            //   text: "Our Mission",
            //   weight: FontWeight.w500,
            //   size: 35,
            // ),
            aboutItems("Dr Uzair Iqbal Janjua", "Supervisor"),
            aboutItems("Dr Mustafa madani", "Co-Supervisor"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: "Developers",
                  weight: FontWeight.w500,
                  size: 35,
                  color: Colors.amber,
                ),
              ],
            ),
            aboutItems("Muhammad Umair Bin Sajid", "project leader"),
            aboutItems("Uzair Asghar", "Chota sa chasky wala"),
            Column(
              children: [
                CustomText(
                  text: "Project By",
                  // size: ,
                  // weight: FontWeight.bold,
                ),
                CustomText(
                  text: 'Comsats Islamabad',
                  weight: FontWeight.bold,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }

  Container aboutItems(String nam, String detail) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: Get.width / 1.75,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: nam,
                    size: 25,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              CustomText(text: detail)
            ],
          )
        ],
      ),
    );
  }
}
