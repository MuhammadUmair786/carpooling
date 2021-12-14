import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getwidget/getwidget.dart';

class ViewProfile extends StatelessWidget {
  final UserModel user;

  const ViewProfile({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80 "),
                  radius: 50.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Muhammad Uzair",
                    size: 25,
                    color: Colors.blueGrey,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.verified)
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 30,
                  ),
                  // SizedBox(width: 5),
                  CustomText(
                    text: "Islamabad, Pakistan",
                    size: 22,
                    color: Colors.blueGrey,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileDetailItem("Member Since", "2018", 1),
                        profileDetailItem("Last Ride", "3 Days ago", 2),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileDetailItem("Profile Complete", "85%", 1),
                        profileDetailItem("Rating", "4.5", 2),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileDetailItem("Reviews", "5", 1),
                        profileDetailItem("Rides", "16", 2),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              // Container(
              //   child: Column(
              //     children: [
              //       profileValues("Member since", "2000"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       profileValues("Last Ride", "3 days"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       profileValues("Languages", "Punjabi English Urdu"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       profileValues("Profile completion", "85%"),
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     CustomText(
              //       text: "Reviews",
              //       size: 22,
              //     ),
              //     Spacer(),
              //     RatingBar(
              //       initialRating: 3.5,
              //       minRating: 1,
              //       direction: Axis.horizontal,
              //       allowHalfRating: true,
              //       itemCount: 5,
              //       ratingWidget: RatingWidget(
              //         full: Icon(
              //           Icons.star,
              //           size: 20,
              //           color: Colors.yellow,
              //         ),
              //         half: Icon(
              //           Icons.star_half,
              //           size: 20,
              //           color: Colors.yellow,
              //         ),
              //         empty: Icon(
              //           Icons.star,
              //           size: 15,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //       onRatingUpdate: (rating) {
              //         print(rating);
              //       },
              //     ),
              //   ],
              // ),
              commentBox(),
              commentBox(),
              commentBox(),
              commentBox(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget profileDetailItem(String title, String value, int alignmnent) {
    // alignmnent == 1 Start, otherwise end
    return Column(
      crossAxisAlignment:
          alignmnent == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        CustomText(text: title, size: 16),
        SizedBox(height: 5),
        CustomText(
          text: value,
          weight: FontWeight.bold,
          size: 20,
        )
      ],
    );
  }

  Container commentBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // color: Colors.blue,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80 "),
                radius: 30,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Muhammad Ali",
                    size: 18,
                    weight: FontWeight.w400,
                  ),
                  GFRating(
                    color: GFColors.SUCCESS,
                    borderColor: GFColors.SUCCESS,
                    filledIcon: Icon(Icons.star, color: GFColors.SUCCESS),
                    defaultIcon: Icon(
                      Icons.star,
                      color: GFColors.LIGHT,
                    ),
                    size: GFSize.SMALL,
                    value: 3.5,
                    onChanged: (value) {},
                  ),
                ],
              ),
              Spacer(),
              CustomText(
                text: "2 days ago",
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(height: 8),
          Container(
              child: CustomText(
                  size: 18,
                  text:
                      "text A repres thbject.  A representation of the runtime type of the object."))
        ],
      ),
    );
  }

  Row profileValues(String x, String y) {
    return Row(
      children: [
        CustomText(
          text: x,
          size: 22,
        ),
        Spacer(),
        CustomText(
          text: y,
          size: 20,
        ),
      ],
    );
  }
}
