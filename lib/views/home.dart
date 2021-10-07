// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carpooling_app/views/drawer/addCash.dart';
import 'package:carpooling_app/views/drawer/statistics.dart';
import 'package:carpooling_app/views/rides/postRide.dart';
import 'package:carpooling_app/views/rides/postedRideInfo.dart';
import 'package:carpooling_app/views/vehicle/addvehicle.dart';

import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// Color begroundColor = Colors.purple.withOpacity(0.2);

// Color.fromRGBO(187, 134, 252, 1);

class Home extends StatelessWidget {
  // var app  = AppBar().;
  // double height = AppBar().preferredSize.height;
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
  // List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            print("refresh");
          },
          child: Container(
            // color: begroundColor,

            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     // currentUser!.reload();
                  //     print(Auth.currentUser!.providerData[0].displayName);

                  //   },
                  //   child: Text("check"),
                  // ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    // color: Color.fromRGBO(187, 134, 252, 1),
                    // color: begroundColor,
                    color: Color.fromRGBO(187, 134, 252, 0.5),

                    child: Stack(
                      children: [
                        Container(
                          height: 70,
                          color: Colors.purple,
                          // width: 200,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          // height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                // offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width / 1.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                        "Uzair Iqbal",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.justify,
                                        // textScaleFactor: 1.2,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 22,
                                            // fontWeight: FontWeight.,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.verified)
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              CustomText(
                                text: "Account Balance",
                                size: 14,
                              ),
                              SizedBox(height: 5),
                              Container(
                                // color: Colors.amber,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "RS. 500",
                                      size: 25,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.to(() => AddCash());
                                          },
                                          child: Text(
                                            "Add Cash",
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.replay_outlined,
                                    size: 16,
                                  ),
                                  CustomText(
                                    text: " Updated Just Now",
                                    size: 13,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
