import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/database/rideDatabase.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/models/requestRideModel.dart';
// import 'package:carpooling_app/models/requestRideModel.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:carpooling_app/views/chating/chatRoom.dart';
import 'package:carpooling_app/views/rides/rideMap.dart';
import 'package:carpooling_app/views/viewProfile.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/generateRoomId.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        backgroundColor: Color(0xFFF4793E),
        title: Text("Ride Detail"),
        actions: [
          if (ride.driverId == Get.find<BottomNavBarController>().getUser!.id)
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                    onPressed: () {},
                    splashRadius: 25,
                    iconSize: 28,
                    icon: Icon(Icons.arrow_upward_outlined)),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {},
                  splashRadius: 25,
                  iconSize: 28,
                  icon: Icon(Icons.delete_forever),
                ),
              ]),
            )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      // height: 155,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(Icons.trip_origin,
                                        color: Color(0xFFF4793E)),
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
                                    Icon(Icons.location_on,
                                        color: Color(0xFFF4793E)),
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            Icon(

                                                // "Bike" : "Car"

                                                Icons.alt_route_outlined),
                                            Text(
                                              ride.route,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.justify,
                                              // textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 18,
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
                                              fontSize: 15,
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
                            child: TextButton(
                              onPressed: () {
                                Get.to(
                                  () => RideMap(
                                      origin: ride.startPoint,
                                      destination: ride.endPoint),
                                );
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(70, 35),
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: CustomText(
                                text: "View on Map",
                                weight: FontWeight.w500,
                                color: Colors.blue,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // height: 205,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF4793E)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: 'Id # ',
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: Colors.black),
                              CustomText(
                                text: '353253463464',
                                size: 14,
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
                    SizedBox(height: 10),
                    //add your logic here
                    // ride.requestList.length == 0
                    //     ? Container()
                    //     :
                    if (ride.driverId ==
                        Get.find<BottomNavBarController>().getUser!.id)
                      RequestSession(
                        // completeList: ride.requestList,
                        rideID: ride.id,
                        confirmedSeats: ride.confirmedSeats,
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

  // Row startEndItem(IconData ic, String locationName) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Icon(ic),
  //       SizedBox(width: 5),
  //       Container(
  //         alignment: Alignment.topLeft,
  //         width: Get.width / 1.9,
  //         child: Text(
  //           locationName,
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 1,
  //           textAlign: TextAlign.justify,
  //           // textScaleFactor: 1.2,
  //           style: TextStyle(
  //               decoration: TextDecoration.none,
  //               fontSize: 18,
  //               // fontWeight: FontWeight.,
  //               color: Colors.black),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget rideDetailItem(String title, String value, int alignmnent) {
    // alignmnent == 1 Start, otherwise end
    return Column(
      crossAxisAlignment:
          alignmnent == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        CustomText(
            text: title,
            size: 14,
            weight: FontWeight.bold,
            color: Colors.black),
        CustomText(
          text: value,
          size: 14,
        )
      ],
    );
  }
}

class RequestSession extends StatelessWidget {
  // final List<RequestModel> completeList;
  final String rideID;
  final int confirmedSeats;
  RequestSession({
    required this.rideID,
    required this.confirmedSeats,
  });

  // late Iterable<RequestModel> requestedListRM;
  // late Iterable<RequestModel> confirmedListRM;

  // late List<UserModel> requestedUsers = [];

  // late List<UserModel> confirmedUsers = [];
  // bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   requestedListRM =
  //       widget.completeList.where((element) => element.isConfirmed == false);
  //   confirmedListRM =
  //       widget.completeList.where((element) => element.isConfirmed == true);
  //   for (int i = 0; i < requestedListRM.length; i++) {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(requestedListRM.elementAt(i).passangerID)
  //         .get()
  //         .then(
  //             (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
  //       if (documentSnapshot.exists) {
  //         // print("i=$i");
  //         requestedUsers
  //             .add(UserModel.fromDocumentSnapshot(snapshot: documentSnapshot));
  //       }
  //     }).then((value) {
  //       if (confirmedListRM.length > 0) {
  //         // print("reach 1");
  //         for (int j = 0; j < confirmedListRM.length; j++) {
  //           // print("i=$j");
  //           FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(confirmedListRM.elementAt(j).passangerID)
  //               .get()
  //               .then(
  //                   (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //             if (documentSnapshot.exists) {
  //               confirmedUsers.add(
  //                   UserModel.fromDocumentSnapshot(snapshot: documentSnapshot));
  //             }
  //           }).then((value) {
  //             print("reach 2");
  //             setState(() {
  //               isLoading = false;
  //             });
  //           });
  //         }
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return

        // isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     :

        DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Color(0xFFF4793E),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFF4793E),
            tabs: [
              Tab(
                icon: Stack(children: [
                  Icon(
                    Icons.request_page_sharp,
                    size: 30,
                  ),
                  // if (requestedListRM.length >= 1)
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: CircleAvatar(
                  //     radius: 10,
                  //     backgroundColor: Colors.red,
                  //     child: CustomText(
                  //         text: "4",
                  //         // requestedListRM.length.toString(),
                  //         size: 15,
                  //         weight: FontWeight.bold,
                  //         color: Colors.white),
                  //   ),
                  // )
                ]),
                child: CustomText(
                  text: "Requests",
                  weight: FontWeight.w500,
                  size: 14,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                child: CustomText(
                  text: "Confirmed",
                  weight: FontWeight.w500,
                  size: 14,
                ),
              ),
            ],
          ),
          Container(
            height:

                // widget.completeList.length

                4 * 85, //set this height according to the list size in postedRideInfo SCreen
            child: TabBarView(children: [
              //requested passangers
              // requestedListRM.length == 0
              //     ? Center(
              //         child: CustomText(text: "No Request Recieved Yet"),
              //       )
              //     : ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: requestedListRM.length,
              //         itemBuilder: (con, index) {
              //           return RequestedPassangerItem(
              //             user: requestedUsers[index],
              //             request: requestedListRM.elementAt(index),
              //           );
              //         }),

              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      // .collection("ride")
                      // .doc(rideID)
                      .collection("request")
                      .where('rideID', isEqualTo: rideID)
                      .where('isConfirmed', isEqualTo: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length == 0) {
                        return CustomText(text: "No Request Recieved Yet");
                      }
                      return Flex(
                        direction: Axis.vertical,
                        children: snapshot.data!.docs.map((e) {
                          // print(e.data());
                          return RequestedPassangerItem(
                              rideRequestMap: e.data(),
                              rideId: rideID,
                              rideConfirmedSeats: confirmedSeats);
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              //confirmed passangers
              // confirmedListRM.length == 0
              // ?
              // Center(
              //   child: CustomText(text: "No Request Confirmed Yet"),
              // )

              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      // .collection("ride")
                      // .doc(rideID)
                      .collection("request")
                      .where('rideID', isEqualTo: rideID)
                      .where('isConfirmed', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length == 0) {
                        return CustomText(text: "No Request Confirmed Yet");
                      }
                      return Flex(
                        direction: Axis.vertical,
                        children: snapshot.data!.docs.map((e) {
                          // print(e.data());
                          return ConfirmedPassangerItem(
                            rideMap: e.data(),
                            rideId: rideID,
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              // : ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: confirmedListRM.length,
              //     itemBuilder: (con, index) {
              //       return ConfirmedPassangerItem(
              //         user: confirmedUsers[index],
              //         request: confirmedListRM.elementAt(index),
              //       );
              //     }),
            ]),
          ),
        ],
      ),
    );
  }
}

class ConfirmedPassangerItem extends StatefulWidget {
  final Map<String, dynamic> rideMap;
  final String rideId;
  ConfirmedPassangerItem({required this.rideMap, required this.rideId});

  @override
  State<ConfirmedPassangerItem> createState() => _ConfirmedPassangerItemState();
}

class _ConfirmedPassangerItemState extends State<ConfirmedPassangerItem> {
  UserModel? user;

  // late RequestModel request;
  @override
  void initState() {
    super.initState();
    // print(widget.rideMap["driverId"]);
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.rideMap["passangerID"])
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          user = UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
        });
      } else {
        print("User document not found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? CustomText(text: "Loading ...")
        : InkWell(
            onTap: () {
              // showDialog(context: context, builder: builder)
              diologItem();
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
                  // CircleAvatar(
                  //   radius: 35,
                  //   backgroundImage: NetworkImage(
                  //     "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                  //   ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: user!.img ?? Secrets.NO_IMG,
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: this.user!.name,
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
                              widget.rideMap['startAddress'],
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
                  IconButton(
                    onPressed: () {
                      Get.back();

                      Get.to(
                        () => ChatRoom(
                          chatRoomId: RideDatabase.manageChatAndReturnRoomID(
                              this.user!.id, this.user!.name),
                          user: this.user!,
                        ),
                      );
                    },
                    icon: Icon(Icons.message, size: 35),
                  )
                ],
              ),
            )

            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   decoration: const BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(width: 0.25),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       CircleAvatar(
            //         radius: 35,
            //         backgroundImage: NetworkImage(
            //           "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           FittedBox(
            //             fit: BoxFit.scaleDown,
            //             child: CustomText(
            //               text: "Uzair Iqbal",
            //               size: 22,
            //               weight: FontWeight.bold,
            //             ),
            //           ),
            //           Row(
            //             children: [
            //               Icon(Icons.location_pin),
            //               Container(
            //                 width: Get.width / 1.85,
            //                 child: Text(
            //                   "Saddar, GPO",
            //                   overflow: TextOverflow.ellipsis,
            //                   maxLines: 1,
            //                   textScaleFactor: 1.2,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Spacer(),
            //       Icon(Icons.message, size: 35)
            //     ],
            //   ),
            // ),
            );
  }

  Future<dynamic> diologItem() {
    return Get.dialog(
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
                        text: this.user!.name,
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
                        width: Get.width / 1.5,
                        child: Text(
                          widget.rideMap['startAddress'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
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
                      const SizedBox(width: 5),
                      Container(
                        width: Get.width / 1.5,
                        child: Text(
                          widget.rideMap['endAddress'],
                          // this.request.endAddress,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
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
                        size: 20,
                        weight: FontWeight.bold,
                      ),

                      SizedBox(width: 5),
                      CustomText(
                        text: widget.rideMap['seats'].toString(),
                        size: 22,
                        color: Colors.red,
                        weight: FontWeight.bold,
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
                      widget.rideMap['message'],
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
                        onPressed: () {
                          Get.back();
                          RideDatabase.rejectRideRequests(
                            // widget.rideId,
                            widget.rideMap['requestId'],
                          );
                        },
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
                  Get.to(() => ViewProfile(
                        user: this.user!,
                      ));
                },
                child: CachedNetworkImage(
                  imageUrl: user!.img ?? Secrets.NO_IMG,
                  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestedPassangerItem extends StatefulWidget {
  final Map<String, dynamic> rideRequestMap;
  final String rideId;
  final int rideConfirmedSeats;
  RequestedPassangerItem(
      {required this.rideRequestMap,
      required this.rideId,
      required this.rideConfirmedSeats});

  @override
  State<RequestedPassangerItem> createState() => _RequestedPassangerItemState();
}

class _RequestedPassangerItemState extends State<RequestedPassangerItem> {
  UserModel? user;

  // late RequestModel request;
  @override
  void initState() {
    super.initState();
    // print(widget.rideMap["driverId"]);
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.rideRequestMap["passangerID"])
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          user = UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
        });
      } else {
        print("User document not found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? CustomText(text: "Loading ...")
        : InkWell(
            onTap: () {
              // showDialog(context: context, builder: builder)
              showDialog();
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
                  // CircleAvatar(
                  //   radius: 35,
                  //   backgroundImage: NetworkImage(
                  //     "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                  //   ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: user!.img ?? Secrets.NO_IMG,
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: this.user!.name,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xFFF4793E),
                          ),
                          Container(
                            width: Get.width / 3,
                            child: Text(
                              widget.rideRequestMap['startAddress'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                              ),
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

  Future<dynamic> showDialog() {
    return Get.dialog(
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
                        text: this.user!.name,
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
                        width: Get.width / 1.5,
                        child: Text(
                          widget.rideRequestMap['startAddress'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
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
                      const SizedBox(width: 5),
                      Container(
                        width: Get.width / 1.5,
                        child: Text(
                          widget.rideRequestMap['endAddress'],
                          // this.request.endAddress,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              // fontWeight: FontWeight.,
                              color: Colors.black),
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
                        size: 20,
                        weight: FontWeight.bold,
                      ),

                      SizedBox(width: 5),
                      CustomText(
                        text: widget.rideRequestMap['seats'].toString(),
                        size: 22,
                        color: Colors.red,
                        weight: FontWeight.bold,
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
                      widget.rideRequestMap['message'],
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
                        onPressed: () {
                          //reject ride
                          Get.back();
                          RideDatabase.rejectRideRequests(
                            // widget.rideId,
                            widget.rideRequestMap['requestId'],
                          );
                        },
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
                        onPressed: () {
                          Get.back();

                          Get.to(
                            () => ChatRoom(
                              chatRoomId:
                                  RideDatabase.manageChatAndReturnRoomID(
                                      this.user!.id, this.user!.name),
                              user: this.user!,
                            ),
                          );
                        },
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
                        onPressed: () {
                          Get.back();
                          RideDatabase.acceptRideRequests(
                              // widget.rideId,
                              widget.rideRequestMap['requestId'],
                              widget.rideRequestMap['rideID'],
                              widget.rideConfirmedSeats);
                        },
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
                  Get.to(() => ViewProfile(
                        user: this.user!,
                      ));
                },
                child: CachedNetworkImage(
                  imageUrl: user!.img ?? Secrets.NO_IMG,
                  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-zsO-WB5sqXt2_4XGhgNqeecBwQ2dm2dTFcV4NBR0hBIK9nlKRuIz8HUwEo-eEteJBm4&usqp=CAU",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
