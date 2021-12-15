import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/views/rides/requestRide.dart';
import 'package:carpooling_app/views/rides/ride_filters.dart';
import 'package:carpooling_app/views/viewProfile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SearchRidesResponse extends StatefulWidget {
  final LatLng? startPoint;
  final String? startAddress;
  final LatLng? endPoint;
  final String? endAddress;
  final String? startCity;
  final String? endCity;
  final String? startPostalCode;
  final String? endPostalCode;

  final String? startSubLocality;
  final String? endSubLocality;
  //1: search by postalCode (nearby)
  //2: search by city
  //3: exact search
  //4: all rides

  const SearchRidesResponse(
      {Key? key,
      this.startPoint,
      this.startAddress,
      this.endPoint,
      this.endAddress,
      this.startCity,
      this.endCity,
      this.startPostalCode,
      this.endPostalCode,
      this.startSubLocality,
      this.endSubLocality})
      : super(key: key);

  @override
  State<SearchRidesResponse> createState() => _SearchRidesResponseState();
}

class _SearchRidesResponseState extends State<SearchRidesResponse> {
  String genderFilter = "Both";
  String vehicleFilter = "Both";
  Query<Map<String, dynamic>> get queryPostalCode => FirebaseFirestore.instance
      .collection("ride")
      .where('startPostalCode', isEqualTo: widget.startPostalCode)
      .where('endPostalCode', isEqualTo: widget.endPostalCode);

  // Query<Map<String, dynamic>> get queryCordinates => FirebaseFirestore.instance
  // .collection("ride")
  // .where('startPostalCode', isEqualTo: widget.startPostalCode)
  // .where('endPostalCode', isEqualTo: widget.endPostalCode);

  Query<Map<String, dynamic>> get querySubLocality => FirebaseFirestore.instance
      .collection("ride")
      .where('startSubLocality', isEqualTo: widget.startSubLocality)
      .where('endSubLocality', isEqualTo: widget.endSubLocality);

  Query<Map<String, dynamic>> get queryCity => FirebaseFirestore.instance
      .collection("ride")
      .where('startCity', isEqualTo: widget.startCity)
      .where('endCity', isEqualTo: widget.endCity);

  Query<Map<String, dynamic>> getDataQuery({required int queryType}) {
    if (queryType == 1) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startPostalCode', isEqualTo: widget.startPostalCode)
          .where('endPostalCode', isEqualTo: widget.endPostalCode);
    } else if (queryType == 2) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startCity', isEqualTo: widget.startCity)
          .where('endCity', isEqualTo: widget.endCity);
    } else if (queryType == 3) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startSubLocality', isEqualTo: widget.startSubLocality)
          .where('endSubLocality', isEqualTo: widget.endSubLocality);
    } else {
      return FirebaseFirestore.instance.collection("ride");
    }
  }

  Query<Map<String, dynamic>> getQueryWithFilters(int queryType,
      {required String category, required String value}) {
    // print(xc);
    // queryCity.where(field)
    if (queryType == 1) {
      //
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startPostalCode', isEqualTo: widget.startPostalCode)
          .where('endPostalCode', isEqualTo: widget.endPostalCode);
    } else if (queryType == 2) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startCity', isEqualTo: widget.startCity)
          .where('endCity', isEqualTo: widget.endCity);
    } else if (queryType == 3) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startSubLocality', isEqualTo: widget.startSubLocality)
          .where('endSubLocality', isEqualTo: widget.endSubLocality);
    } else {
      return FirebaseFirestore.instance.collection("ride");
    }
  }

  Query<Map<String, dynamic>> x = FirebaseFirestore.instance
      .collection("ride")
      .where('startSubLocality', isEqualTo: "widget.startSubLocality")
      .where('endSubLocality', isEqualTo: "widget.endSubLocality");

// Query<Map<String, dynamic>>
  List<bool> isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: Text("Matching Rides"),
        centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                  splashRadius: 20,
                  // color: Colors.yellow,
                  onPressed: () {
                    Get.to(() => RideFilter());
                  },
                  icon: Icon(Icons.filter_list_alt))),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  fillColor: selectedColor.withOpacity(0.8),
                  borderWidth: 1,
                  selectedBorderColor: selectedColor,
                  // direction: Axis.vertical,
                  borderRadius: BorderRadius.circular(10),
                  // renderBorder: false,
                  children: <Widget>[
                    toggleButtonItem(" City "),
                    toggleButtonItem("Near By"),
                    toggleButtonItem("Exact Match"),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              ),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Icon(Icons.arrow_back_sharp),
              //     Text("MATCHING RIDES"),
              //     Icon(Icons.filter_list_alt)
              //   ],
              // ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("ride")
                      // .where('startPostalCode',
                      //     isEqualTo: widget.startPostalCode)
                      // .where('endPostalCode', isEqualTo: widget.endPostalCode)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length == 0) {
                        return Text("No ride found");
                      }
                      return Flex(
                        direction: Axis.vertical,
                        children: snapshot.data!.docs.map((e) {
                          return RideItem(
                            ride: RideModel.fromDocumentSnapshot(snapshot: e),
                          );
                          // postedRideItem(
                          //     RideModel.fromDocumentSnapshot(snapshot: e),
                          //     context);
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Container toggleButtonItem(String value) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
        color: selectedColor.withOpacity(0.3),
      ),
      child: CustomText(
        text: value,
        size: 20,
        color: Colors.black,
        weight: FontWeight.w500,
      ),
    );
  }
}

class RideItem extends StatefulWidget {
  final RideModel ride;

  const RideItem({Key? key, required this.ride}) : super(key: key);

  @override
  State<RideItem> createState() => _RideItemState();
}

class _RideItemState extends State<RideItem> {
  UserModel? driver;
  IconData getIcon(String x) {
    if (x == "Student") {
      return Icons.school_sharp;
    } else if (x == "Employee") {
      return Icons.laptop_mac_rounded;
    } else {
      return Icons.business_center_rounded;
    }
  }

  @override
  void initState() {
    super.initState();
    // driver = UserModel.fromDocumentSnapshot(snapshot: )
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.ride.driverId)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          driver = UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
          // print(driver!.workingDetails['vsdv']);
        });
      } else {
        print("User document not found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return driver == null
        ? Center(
            child: Text("Loading ...", textScaleFactor: 1.3),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(ViewProfile(user: driver!));
                        // print("maaap");
                        // print(driver!.workingDetails);
                        // print(driver!.workingDetails['type']);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CachedNetworkImage(
                            imageUrl: driver!.img ?? Secrets.NO_IMG,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              strokeWidth: 2,
                            ),
                            // placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Name",
                              //   textScaleFactor: 1.3,
                              // ),
                              Container(
                                width: Get.width / 2,
                                alignment: Alignment.topLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CustomText(
                                    text: driver!.name,
                                    size: 20,
                                  ),
                                ),
                              ),
                              if (driver!.workingDetails.isNotEmpty)
                                Row(
                                  children: [
                                    Icon(
                                        // Icons.ac_unit_rounded,
                                        getIcon(
                                            driver!.workingDetails['type'])),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: Get.width / 2.2,
                                      alignment: Alignment.topLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: CustomText(
                                          text: driver!.workingDetails['type']
                                              .toString(),
                                          // size: 18,
                                        ),
                                      ),
                                    ), //Company detail or anything
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: 120,
                      margin: EdgeInsets.only(right: 8),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 4.0,
                            animation: true,
                            percent: 0.8,
                            center: Text(
                              // percent.toString() + "%",
                              "${Random().nextInt(50) + 50}%",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            // backgroundColor: Colors.grey[300],
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.green,
                          ),
                          CustomText(
                            text: "Match",
                            size: 15,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.ride.startingAddress,
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
                                  Icon(
                                    widget.ride.vehicleType == "Bike"
                                        ? Icons.directions_bike_rounded
                                        : Icons.directions_car_sharp,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.ride.route,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.justify,
                                    // textScaleFactor: 1.2,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                widget.ride.endAddress,
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
                const SizedBox(height: 10),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       children: [
                //         Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Column(
                //                 children: [
                //                   Icon(Icons.trip_origin),
                //                   DottedLine(
                //                     direction: Axis.vertical,
                //                     lineLength: 55,
                //                     lineThickness: 3.0,
                //                     dashLength: 3.0,
                //                     // dashColor: Colors.black,
                //                     dashGradient: [Colors.red, Colors.blue],
                //                     dashRadius: 0.0,
                //                     dashGapLength: 3.0,
                //                     dashGapColor: Colors.transparent,
                //                     // dashGapGradient: [Colors.red, Colors.blue],
                //                     // dashGapRadius: 0.0,
                //                   ),
                //                   Icon(Icons.location_on),
                //                 ],
                //               ),
                //             ),
                //             Expanded(
                //               flex: 7,
                //               child: Container(
                //                 height: 100,
                //                 child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text(
                //                         widget.ride.startingAddress,
                //                         overflow: TextOverflow.ellipsis,
                //                         maxLines: 1,
                //                         textAlign: TextAlign.justify,
                //                         // textScaleFactor: 1.2,
                //                         style: TextStyle(
                //                             decoration: TextDecoration.none,
                //                             fontSize: 20,
                //                             fontWeight: FontWeight.w500,
                //                             color: Colors.black),
                //                       ),
                //                       Row(
                //                         children: [
                // Icon(Icons.alt_route_outlined),
                //                           Text(
                //                             widget.ride.route,
                //                             overflow: TextOverflow.ellipsis,
                //                             maxLines: 1,
                //                             textAlign: TextAlign.justify,
                //                             // textScaleFactor: 1.2,
                //                             style: TextStyle(
                //                                 decoration: TextDecoration.none,
                //                                 fontSize: 22,
                //                                 fontWeight: FontWeight.w500,
                //                                 color: Colors.black),
                //                           ),
                //                         ],
                //                       ),
                //                       Text(
                //                         widget.ride.endAddress,
                //                         overflow: TextOverflow.ellipsis,
                //                         maxLines: 1,
                //                         textAlign: TextAlign.justify,
                //                         // textScaleFactor: 1.2,
                //                         style: TextStyle(
                //                             decoration: TextDecoration.none,
                //                             fontSize: 20,
                //                             fontWeight: FontWeight.w500,
                //                             color: Colors.black),
                //                       ),
                //                     ]),
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(5),
                //               child: Icon(
                // Icons.trip_origin,
                //                 size: 20,
                //               ),
                //             ),
                //             Container(
                //               width: Get.width / 2.8,
                //               alignment: Alignment.topLeft,
                //               child: FittedBox(
                //                 fit: BoxFit.scaleDown,
                //                 child: CustomText(
                //                   text: "Street # 4, 22 No.",
                //                   // size: 2,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         // SizedBox(height: 5),
                //         Row(
                //           children: [
                //             Icon(
                //               Icons.location_on,
                //               //color accordign to government or private
                //               // like green from governmnet
                //               size: 30,
                //             ),
                //             // Text(),
                //             Container(
                //               width: Get.width / 2.8,
                //               alignment: Alignment.topLeft,
                //               child: FittedBox(
                //                 fit: BoxFit.scaleDown,
                //                 child: CustomText(
                //                   text: "Comsats, Islamabad",
                //                   // size: 2,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Icon(
                //           // Icons.pedal_bike,
                //           Icons.directions_car_sharp,
                //           size: 35,
                //         ),
                //         Container(
                //           width: Get.width / 2.8,
                //           alignment: Alignment.topLeft,
                //           child: FittedBox(
                //             fit: BoxFit.scaleDown,
                //             child: CustomText(
                //               text: "Through Fazabad",
                //               // size: 2,
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    driver!.rating.toString(),
                                    textScaleFactor: 1.3,
                                  ),
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.green,
                                    //yellow not visible fix later
                                    size: 22,
                                  )
                                ],
                              ),
                              Text(
                                "Rating",
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    driver!.profileComplete.toString(),
                                    textScaleFactor: 1.3,
                                  ),
                                  Text(
                                    "%",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                              Text(
                                "Profile", //make circle and colors indicating percentage
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      // height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   color: Colors.grey[200],
                          //   // decoration: BoxDecoration(
                          //   //   borderRadius: BorderRadius.circular(10),
                          //   // ),
                          //   padding: EdgeInsets.all(5),
                          //   width: 120,
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Icon(Icons
                          //               .airline_seat_legroom_reduced_sharp),
                          //           Text("2/3"),
                          //           // Text("avilable"),
                          //         ],
                          //       ),
                          //       Row(
                          //         children: [
                          //           Text("8"),
                          //           Icon(Icons.redo)
                          //           // Text("Request send"),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => RequestRide(
                                    rideId: widget.ride.id,
                                    driverId: widget.ride.driverId));
                              },
                              child: Container(
                                // color: Colors.grey[200],
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // padding: EdgeInsets.all(5),
                                width: 100,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .airline_seat_legroom_reduced_sharp,
                                            ),
                                            CustomText(
                                              text:
                                                  "${widget.ride.confirmedSeats}/${widget.ride.totalSeats}",
                                              weight: FontWeight.w300,
                                            ),

                                            // Text("avilable"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("${Random().nextInt(15)}"
                                                // driver!.postedRidesList.length
                                                //   .toString()

                                                ),
                                            Icon(Icons.visibility)
                                            // Text("Request send"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3),
                                        child: Text("Sent Request")),
                                  ],
                                ),
                              )

                              // Text("Sent Request"),
                              // style: ButtonStyle(
                              //   padding: EdgeInsetsGeometry.,
                              // ),
                              )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
