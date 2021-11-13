import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/views/rides/postRide.dart';
import 'package:carpooling_app/views/rides/postedRideInfo.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class RideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.directions_car),
                    child: Text("Posted"),
                  ),
                  Tab(
                    icon: Icon(Icons.request_page_sharp),
                    child: Text("Requested"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PostedRides(),
                    RequestedRides(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostedRides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var rideList = Get.find<AuthController>().userData!.postedRidesList;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => PostRide());
                  // showDialog(
                  //   barrierColor: Colors.grey.withOpacity(0.8),
                  //   context: context,
                  //   builder: (_) => dioloadChild(),
                  // );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.add_box,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "Add new Ride",
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("ride")
                      .where('driverID',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length == 0) {
                        return Text("No ride found");
                      }
                      return Flex(
                        direction: Axis.vertical,
                        children: snapshot.data!.docs.map((e) {
                          return postedRideItem(
                              RideModel.fromDocumentSnapshot(snapshot: e),
                              context);
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                   
                  }),
              // postedRideItem(),
              // postedRideItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => PostRide());
          // showDialog(
          //   barrierColor: Colors.grey.withOpacity(0.8),
          //   context: context,
          //   builder: (_) => dioloadChild(),
          // );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Container dioloadChild() {
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Material(
  //           shape: CircleBorder(),
  //           color: Colors.transparent,
  //           child: InkWell(
  //             onTap: () {
  //               Get.back();
  //               Get.to(() => PostRide(rideType: 1));
  //             },
  //             child: Container(
  //               decoration: new BoxDecoration(
  //                 border: Border.all(color: Colors.white, width: 2.5),
  //                 shape: BoxShape.circle,
  //               ),
  //               padding: EdgeInsets.all(20),
  //               margin: EdgeInsets.symmetric(vertical: 10),
  //               child: Icon(
  //                 Icons.quick_contacts_mail,
  //                 color: Colors.white,
  //                 size: 40,
  //               ),
  //             ),
  //           ),
  //         ),
  //         CustomText(
  //           text: "Quick Ride",
  //           color: Colors.white,
  //           weight: FontWeight.bold,
  //           size: 23,
  //         ),
  //         SizedBox(height: 10),
  //         Material(
  //           shape: CircleBorder(),
  //           color: Colors.transparent,
  //           child: InkWell(
  //             onTap: () {
  //               Get.back();
  //               Get.to(() => PostRide(rideType: 2));
  //             },
  //             child: Container(
  //               decoration: new BoxDecoration(
  //                 border: Border.all(color: Colors.white, width: 2.5),
  //                 shape: BoxShape.circle,
  //               ),
  //               padding: EdgeInsets.all(20),
  //               margin: EdgeInsets.symmetric(vertical: 10),
  //               child: Icon(
  //                 Icons.schedule,
  //                 color: Colors.white,
  //                 size: 40,
  //               ),
  //             ),
  //           ),
  //         ),
  //         CustomText(
  //           text: "Schedule Ride",
  //           color: Colors.white,
  //           weight: FontWeight.bold,
  //           size: 23,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget postedRideItem(RideModel ride, BuildContext context) {
    // if(ride.date.)
    // print(Jiffy(ride.).fromNow());
    return GestureDetector(
      onTap: () {
        Get.to(() => PostedRideInfo(
              ride: ride,
            ));
      },
      // splashColor: Colors.transparent,
      // radius: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(width: 0.5),
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
            CustomText(
              text: "Posted: ${Jiffy(ride.postedDate).fromNow()}",
              size: 15,
              weight: FontWeight.bold,
              color: Colors.blueGrey,
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
                    startEndItem(Icons.trip_origin, ride.startingAddress),
                    SizedBox(height: 5),
                    startEndItem(Icons.location_on, ride.endAddress),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl: ride.vehicleImg,
                  // fit: BoxFit.cover,
                  // repeat: ImageR,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2,
                  ),
                  // placeholder: (context, url) => CircularProgressIndicator(),

                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              ],
            ),
            Container(
              color: Colors.grey,
              height: 0.5,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.visibility_sharp),
                CustomText(text: "23"),
                Container(
                  color: Colors.grey,
                  width: 1,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 20,
                ),
                Icon(Icons.outbond_sharp),
                CustomText(text: "45"),
                Spacer(),
                CustomText(
                  text:
                      "Start on: ${Jiffy(ride.startDate).MMMd}, ${ride.time.format(context)}",
                  size: 15,
                  weight: FontWeight.bold,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
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
          width: Get.width / 1.9,
          child: Text(
            locationName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.justify,
            // textScaleFactor: 1.2,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18,
                // fontWeight: FontWeight.,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class RequestedRides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            requestedRideItem(),
            requestedRideItem(),
          ],
        ),
      ),
    );
  }

  Container requestedRideItem() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          CustomText(
            text: "Requested: Yesterday, 8:50 PM",
            size: 15,
            weight: FontWeight.bold,
            color: Colors.deepPurple,
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
            children: [
              CustomText(text: "Pending"),
              Spacer(),
              CustomText(
                text: "Expired: Today, 6:50 AM",
                size: 15,
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
