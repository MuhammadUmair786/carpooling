import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/models/requestRideModel.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/views/rides/rideMap.dart';
import 'package:carpooling_app/views/viewProfile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/size/gf_size.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:dotted_line/dotted_line.dart';
import 'package:jiffy/jiffy.dart';

class PostedRideInfo extends StatelessWidget {
  final RideModel ride;

  PostedRideInfo({required this.ride});

  // var rideList = Get.find<AuthController>().userData!.vehicleList;

  @override
  Widget build(BuildContext context) {
    // var x = rideList.firstWhere((item) == );
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Detail"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.delete_forever,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //     height: 150,
              //     width: double.infinity,
              //     child: Text(
              //       "Map with origion destination ",
              //     ),
              //     color: Colors.lightGreenAccent),
              // Container(
              //   height: 250,
              //   child: GoogleMap(
              //     initialCameraPosition: CameraPosition(
              //       target: const LatLng(33.578891, 73.039483),
              //       zoom: 17.0,
              //     ),
              //     // compassEnabled: false,
              //     // markers: _markers.toSet(),
              //     // zoomControlsEnabled: false,
              //     myLocationButtonEnabled: true,
              //     myLocationEnabled: true,
              //     trafficEnabled: true,
              //     onTap: (cordinate) {
              //       // _currentCoordinates = cordinate;
              //       // // print(cordinate);
              //       // setState(() {
              //       //   _markers = [];
              //       //   _markers.add(
              //       //     Marker(
              //       //       markerId: MarkerId(cordinate.toString()),
              //       //       position: cordinate,
              //       //       draggable: true,
              //       //       onDragEnd: (dragEndPosition) {
              //       //         // print(dragEndPosition.toString() + " end point");
              //       //       },
              //       //     ),
              //       //   );
              //       // });
              //     },
              //   ),
              // ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(text: 'Id # '),
                              CustomText(
                                text: '353253463464',
                                size: 20,
                                weight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              Spacer(),
                              Icon(
                                Icons.copy,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rideDetailItem("Posted",
                                  Jiffy(ride.postedDate).fromNow(), 1),
                              rideDetailItem("Expired", "------", 2),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rideDetailItem("Start date",
                                  Jiffy(ride.startDate).yMMMEd, 1),
                              rideDetailItem(
                                  "Start Time", ride.time.format(context), 2),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rideDetailItem(
                                  "Gender Preference", ride.gender, 1),
                              rideDetailItem("Vehicle", "mehran 2018", 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(Icons.trip_origin),
                                    DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 55,
                                      lineThickness: 3.0,
                                      dashLength: 3.0,
                                      // dashColor: Colors.black,
                                      dashGradient: [Colors.red, Colors.blue],
                                      dashRadius: 0.0,
                                      dashGapLength: 3.0,
                                      dashGapColor: Colors.transparent,
                                      // dashGapGradient: [Colors.red, Colors.blue],
                                      // dashGapRadius: 0.0,
                                    ),
                                    Icon(Icons.location_on),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  height: 100,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ride.startingAddress,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          // textScaleFactor: 1.2,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.alt_route_outlined),
                                            Text(
                                              ride.route,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.justify,
                                              // textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          ride.endAddress,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.justify,
                                          // textScaleFactor: 1.2,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () => RideMap(
                                        origin: ride.startPoint,
                                        destination: ride.endPoint),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(70, 35),
                                  primary: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: CustomText(
                                  text: "View on Map",
                                  weight: FontWeight.w500,
                                )),
                          )
                        ],
                      ),
                    ),
                    RequestSession(
                      completeList: ride.requestList,
                    ),
                  ],
                ),
              )
            ],
          ),
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

  Widget rideDetailItem(String title, String value, int alignmnent) {
    // alignmnent == 1 Start, otherwise end
    return Column(
      crossAxisAlignment:
          alignmnent == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        CustomText(text: title, size: 14),
        CustomText(
          text: value,
          weight: FontWeight.w500,
          size: 18,
        )
      ],
    );
  }
}

class RequestSession extends StatelessWidget {
  final List<RequestModel> completeList;

  RequestSession({required this.completeList});

  @override
  Widget build(BuildContext context) {
    // var requestedRide = requestsList.where((item));
    var requestedList =
        completeList.where((element) => element.isConfirmed == false);
    var confirmedList =
        completeList.where((element) => element.isConfirmed == true);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: SizedBox(
                  width: 45,
                  height: 30,
                  child: Stack(children: [
                    Icon(
                      Icons.request_page_sharp,
                      size: 40,
                      color: Colors.blue,
                    ),
                    if (requestedList.length >= 1)
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: CustomText(
                              text: requestedList.length.toString(),
                              size: 15,
                              weight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                  ]),
                ),
                child: CustomText(
                  text: "Requests",
                  weight: FontWeight.w500,
                  size: 18,
                ),
              ),
              Tab(
                icon: SizedBox(
                  // width: 50,
                  height: 30,
                  child: Icon(
                    Icons.directions_car,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                child: CustomText(
                  text: "Confirmed",
                  weight: FontWeight.w500,
                  size: 18,
                ),
              ),
            ],
          ),
          Container(
            height:
                200, //set this height according to the list size in postedRideInfo SCreen
            child: TabBarView(children: [
              ListView(
                shrinkWrap: true,
                children: [
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("user")
                          .doc()
                          // .where('driverID',
                          //     isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.length == 0) {
                            return Text("No Request found");
                          }
                          return Flex(
                            direction: Axis.vertical,
                            children: snapshot.data!.docs.map((e) {
                              return
                                  // postedRideItem(
                                  //     RideModel.fromDocumentSnapshot(snapshot: e),
                                  //     context)
                                  requestedPassangersItem();
                            }).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  requestedPassangersItem(),
                  requestedPassangersItem(),
                ],
              ),
              //confirmed passangers
              ListView(
                shrinkWrap: true,
                children: [
                  confirmedPassangersItem(),
                  confirmedPassangersItem(),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget confirmedPassangersItem() {
    return InkWell(
      onTap: () {
        // showDialog(context: context, builder: builder)
        Get.dialog(
          Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: Get.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 40),

                      Container(
                        width: Get.width / 1.5,
                        alignment: Alignment.topCenter,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                            text: "Uzair Iqbal",
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // CustomText(text: "Uzair Iqbal",size: 22,weight: FontWeight.bold,),
                      SizedBox(height: 5),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: Get.width / 1.65,
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: "Saddar GPO  d",
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: Get.width / 1.65,
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: "Saddar GPO  d",
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.airline_seat_legroom_reduced_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text: "Requested Seats:",
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text: "2",
                            size: 22,
                            color: Colors.red,
                          )
                          // Icon(Icons.trip_origin_sharp),
                          // SizedBox(width: 5),
                          // Container(
                          //   width: Get.width / 1.65,
                          //   alignment: Alignment.topLeft,
                          //   child: FittedBox(
                          //     fit: BoxFit.scaleDown,
                          //     child: CustomText(
                          //       text: "Saddar GPO  d",
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Container(
                        height: 70,
                        // color: Colors.red,
                        child: Text(
                          "hi, i want to join you in this trip, please get me in, i will be very hankfull to you, we also have one fridge with us and one tv and only one washing machine, i hope their is enough space in your honda civic 2020",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          // textScaleFactor: 1.2,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  text: "Cancel Booking",
                                  size: 18,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.chat_sharp,
                          //         color: Colors.pink,
                          //       ),
                          //       SizedBox(width: 5),
                          //       CustomText(
                          //         text: "Chat",
                          //         size: 18,
                          //         weight: FontWeight.bold,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.done,
                          //         color: Colors.green,
                          //         size: 26,
                          //       ),
                          //       SizedBox(width: 5),
                          //       CustomText(
                          //         text: "Accept",
                          //         size: 18,
                          //         weight: FontWeight.bold,
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // screenWidth/2 - side margin - image half length
                  left: Get.width / 2 - 20 - 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ViewProfile());
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
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
                "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: "Uzair Iqbal",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    Container(
                      width: Get.width / 1.85,
                      child: Text(
                        "Saddar, GPO",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.message, size: 35)
          ],
        ),
      ),
    );
  }

  Widget requestedPassangersItem() {
    return InkWell(
      onTap: () {
        // showDialog(context: context, builder: builder)
        Get.dialog(
          Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: Get.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 40),

                      Container(
                        width: Get.width / 1.5,
                        alignment: Alignment.topCenter,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                            text: "Uzair Iqbal",
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // CustomText(text: "Uzair Iqbal",size: 22,weight: FontWeight.bold,),
                      SizedBox(height: 5),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: Get.width / 1.65,
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: "Saddar GPO  d",
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: Get.width / 1.65,
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: "Saddar GPO  d",
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.airline_seat_legroom_reduced_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text: "Requested Seats:",
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text: "2",
                            size: 22,
                            color: Colors.red,
                          )
                          // Icon(Icons.trip_origin_sharp),
                          // SizedBox(width: 5),
                          // Container(
                          //   width: Get.width / 1.65,
                          //   alignment: Alignment.topLeft,
                          //   child: FittedBox(
                          //     fit: BoxFit.scaleDown,
                          //     child: CustomText(
                          //       text: "Saddar GPO  d",
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Container(
                        height: 70,
                        // color: Colors.red,
                        child: Text(
                          "hi, i want to join you in this trip, please get me in, i will be very hankfull to you, we also have one fridge with us and one tv and only one washing machine, i hope their is enough space in your honda civic 2020",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          // textScaleFactor: 1.2,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  text: "Reject",
                                  size: 18,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chat_sharp,
                                  color: Colors.pink,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  text: "Chat",
                                  size: 18,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                  size: 26,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  text: "Accept",
                                  size: 18,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  // screenWidth/2 - side margin - image half length
                  left: Get.width / 2 - 20 - 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ViewProfile());
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          // color: Colors.grey,
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
                "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: "Uzair Iqbal",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    Container(
                      width: Get.width / 3,
                      child: Text(
                        "Saddar, GPO",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
