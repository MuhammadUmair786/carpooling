import 'package:carpooling_app/views/viewProfile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PostedRideInfo extends StatelessWidget {
  const PostedRideInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

              Container(
                height: 250,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: const LatLng(33.578891, 73.039483),
                    zoom: 17.0,
                  ),
                  // compassEnabled: false,
                  // markers: _markers.toSet(),
                  // zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  trafficEnabled: true,
                  onTap: (cordinate) {
                    // _currentCoordinates = cordinate;
                    // // print(cordinate);
                    // setState(() {
                    //   _markers = [];
                    //   _markers.add(
                    //     Marker(
                    //       markerId: MarkerId(cordinate.toString()),
                    //       position: cordinate,
                    //       draggable: true,
                    //       onDragEnd: (dragEndPosition) {
                    //         // print(dragEndPosition.toString() + " end point");
                    //       },
                    //     ),
                    //   );
                    // });
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
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
                              rideDetailItem("Posted", "5 days ago", 1),
                              rideDetailItem("Expired", "12 Aug, 12:34 PM", 2),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rideDetailItem("Start date", "12 Aug, 2020", 1),
                              rideDetailItem("Start Time", "12:34 PM", 2),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rideDetailItem(
                                  "Gender Preference", "Male Only", 1),
                              rideDetailItem("Vehicle", "Mehran 2018", 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TabsView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
          size: 20,
        )
      ],
    );
  }
}

class TabsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                child: Text("Confirmed"),
              ),
              Tab(
                icon: Icon(Icons.request_page_sharp),
                child: Text("Requests"),
              ),
            ],
          ),
          Container(
            height:
                200, //set this height according to the list size in postedRideInfo SCreen
            child: TabBarView(children: [
              //confirmed passangers
              ListView(
                shrinkWrap: true,
                children: [
                  confirmedPassangersItem(),
                  confirmedPassangersItem(),
                ],
              ),

              ListView(
                shrinkWrap: true,
                children: [
                  requestedPassangersItem(),
                  requestedPassangersItem(),
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
