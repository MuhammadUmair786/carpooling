import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Rides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_sharp),
                Text("MATCHING RIDES"),
                Icon(Icons.filter_list_alt)
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(10),
              // height: 40,
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                textScaleFactor: 1.3,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.school_sharp), SizedBox(width: 5),
                                  Text("Comsats"), //Company detail or anything
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                child: CircularPercentIndicator(
                                  radius: 45.0,
                                  lineWidth: 4.0,
                                  animation: true,
                                  percent: 0.8,
                                  center: Text(
                                    // percent.toString() + "%",
                                    "80%",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  // backgroundColor: Colors.grey[300],
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                )),
                            Text(
                              "Match",
                              style: TextStyle(
                                  // fontSize: 15.0,
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  Icons.trip_origin,
                                  size: 20,
                                ),
                              ),
                              Text("Street # 4, 22 No.")
                            ],
                          ),
                          // SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                //color accordign to government or private
                                // like green from governmnet
                                size: 30,
                              ),
                              Text("Comsats, Islamabad")
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            // Icons.pedal_bike,
                            Icons.directions_car_sharp,
                            size: 35,
                          ),
                          Text("Through Fazabad")
                        ],
                      )
                    ],
                  ),
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
                                      "4",
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
                                      "80",
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
                                onPressed: () {},
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
                                              Text("2/3"),

                                              // Text("avilable"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("8"),
                                              Icon(Icons.redo)
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
            ),
            Text("svs"),
          ],
        ),
      ),
    );
  }
}
