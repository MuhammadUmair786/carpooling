// import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/database/rideDatabase.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/payment.dart';
import 'package:carpooling_app/views/rides/postRide.dart';
import 'package:carpooling_app/views/rides/postedRideInfo.dart';
import 'package:carpooling_app/views/vehicle/addvehicle.dart';

import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'drawer/addCash.dart';
import 'drawer/statistics.dart';
import 'rides/tempSearchMap.dart';

// Color begroundColor = Colors.purple.withOpacity(0.2);

// Color.fromRGBO(187, 134, 252, 1);

class Home extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> dataSnapchots;

  const Home({Key? key, required this.dataSnapchots}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _controller = Get.find<BottomNavBarController>();

  @override
  void initState() {
    super.initState();
    // print(widget.dataSnapchots.data());
    // _controller.userData.value =
    //     UserModel.fromDocumentSnapshot(snapshot: widget.dataSnapchots);
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<DocumentSnapshot<Map<String, dynamic>>> _usersStream =
    //     FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(Get.find<AuthController>().userfb!.uid)
    //         .snapshots();
    // _usersStream.listen(
    //   (data) {
    //     // print(data.get('name'));
    //     xsd = data.get('name');
    //   },
    // );
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            print("refresh");
          },
          child: Container(
            // color: begroundColor,

            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: _controller.getUser == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // TextButton(
                        //     onPressed: () {
                        //       // UserDatabase.unlinkEmail();
                        //       print(FirebaseAuth
                        //           .instance.currentUser!.providerData[0].email
                        //           .toString());
                        //     },
                        //     child: Text("dfsdsdgsd")),
                        // TextButton(
                        // onPressed: () {
                        // currentUser!.reload();
                        // print(Auth.currentUser!.providerData[0].displayName);
                        // print(Get.find<AuthController>().userData!.name);
                        //  = "fd";
                        // Stream
                        //  var documentStream =

                        // var x = documentStream;

                        // print("length === " + documentStream['saf']);

                        // final Stream<DocumentSnapshot<Map<String, dynamic>>>
                        //     _usersStream = FirebaseFirestore.instance
                        //         .collection('users')
                        //         .doc(Get.find<AuthController>().userfb!.uid)
                        //         .snapshots();
                        // _usersStream.listen(
                        //   (data) {
                        //     print(data.get('name'));
                        //   },
                        // );
                        // },
                        // child: Text("check"),
                        // ),
                        // Text(controller.userData!.name, textScaleFactor: 1.5),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          // color: Color.fromRGBO(187, 134, 252, 1),
                          // color: begroundColor,
                          color: Color(0xFFF4793E).withOpacity(0.2),
                          // Color.fromRGBO(187, 134, 252, 0.5),

                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                color: Color(0xFFF4793E),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Text(
                                              widget.dataSnapchots
                                                  .data()!['name'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.justify,
                                              // textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                                            text:
                                                "RS. ${widget.dataSnapchots.data()!['balance']}",
                                            size: 25,
                                            weight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            height: 25,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFF4793E),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.to(() => PaymentScreen());
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
                        DisplayDiscountDetails(),
                        // SizedBox(height: 30),

                        Container(
                          // color: Colors.yellow[100],
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              shortcutButtons("Add Vehicle", () {
                                Get.to(() => AddVehicle());
                              }, Icons.local_taxi_rounded),
                              shortcutButtons("Statistics", () {
                                Get.to(() => Statistics());
                              }, Icons.query_stats),
                              shortcutButtons("Post Ride", () {
                                Get.to(() => PostRide());
                              }, Icons.add_location_alt),

                              // shortcutButtons(),
                              // shortcutButtons(),
                            ],
                          ),
                        ),
                        // SizedBox(height: 30),

                        Container(
                          // color: Colors.blue[100],
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CustomText(
                                  text: "Upcomming Rides",
                                  size: 20,
                                  weight: FontWeight.bold,
                                  // color: Colors.yellow,
                                ),
                              ),
                              // SizedBox(height: 20),
                              upcommingRideItem(),
                              upcommingRideItem(),
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

  Container upcommingRideItem() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      // color: Colors.blue,v c
      decoration: BoxDecoration(
        color: Color(0xFFF4793E),
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1.5,
            blurRadius: 2,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.time_to_leave, size: 30, color: Colors.white),
          ),
          SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: Get.width / 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: "Comsats Isl",
                    size: 18,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              CustomText(
                text: "Tommorrow, 08:00 PM",
                color: Colors.white,
                size: 13,
                //             size: 14,
                // weight: FontWeight.bold,
              )
            ],
          ),
          Spacer(),
          SizedBox(
            height: 20,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  // primary: Colors.purple[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Get.to(() => PostedRideInfo());
                },
                child: CustomText(
                  text: "See Details",
                  size: 10,
                  color: Color(0xFFF4793E),
                )),
          )
        ],
      ),
    );
  }

  Widget shortcutButtons(String title, Function() fun, IconData icon) {
    return InkWell(
      // splashColor: Colors.grey,

      onTap: fun,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2.5,
              blurRadius: 2,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Color(0xFFF4793E)),
            SizedBox(height: 5),
            Container(
              child: CustomText(
                text: title,
                size: 14,
                weight: FontWeight.bold,
                // color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DisplayDiscountDetails extends StatefulWidget {
  @override
  _DisplayDiscountDetailsState createState() => _DisplayDiscountDetailsState();
}

class _DisplayDiscountDetailsState extends State<DisplayDiscountDetails> {
  IconData _icon = Icons.arrow_drop_down;
  bool showDropDown = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (showDropDown) {
            _icon = Icons.arrow_drop_down;
            showDropDown = false;
          } else {
            _icon = Icons.arrow_drop_up;
            showDropDown = true;
          }
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        color: Color(0xFFF4793E).withOpacity(0.2),
        duration: Duration(seconds: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Get Discount",
                  size: 22,
                  weight: FontWeight.bold,
                  // color: Colors.yellow,
                ),
                Icon(
                  _icon,
                  size: 35,
                ),
              ],
            ),
            if (showDropDown)
              Column(
                children: [
                  discountItem("Rating", "Maintain 4.5 or above", "4.5/5.0"),
                  discountItem(
                      "Rides", "Complete at least 5 rides in a month", "0/5"),
                  discountItem(
                      "Earning", "Utilize at least RS 300 in a month", "0/300"),
                  discountItem(
                      "Cancelation", "Not more then two cancel rides", "0/2"),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Container discountItem(String title, String description, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  // color: Colors.yellow,
                  weight: FontWeight.bold,
                  size: 17,
                ),
                SizedBox(height: 5),
                Container(
                  child: CustomText(
                    text: description,
                    size: 13,
                    //color: Colors.yellow,
                    // weight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 25),
          CustomText(
            text: value,
            weight: FontWeight.bold,
            size: 15,
            color: Colors.green[700],
          )
        ],
      ),
    );
  }
}
