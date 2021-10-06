import 'package:carousel_slider/carousel_slider.dart';
import 'package:carpooling_app/views/drawer/addCash.dart';

import 'package:carpooling_app/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

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
                    margin: EdgeInsets.only(bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 80,
                          color: Colors.blue[400],
                          // width: 200,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
                              SizedBox(height: 3),
                              CustomText(
                                text: "Account Balance",
                                size: 14,
                              ),
                              // SizedBox(height: 3),
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
                              // SizedBox(height: 4),
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

                  //having margin from now
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       //percent value must be between 0.0 - 1.0
                        //       percentageCircles(0.8, "Positive", "Rating"),
                        //       percentageCircles(0.85, "Ride", "Completion"),
                        //       percentageCircles(0.85, "Profile", "Completion"),
                        //       percentageCircles(0.65, "Response", "Time"),
                        //     ],
                        //   ),
                        // ),
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
                                children: [
                                  Icon(Icons.ac_unit_sharp),
                                  CustomText(
                                    text: "Monthly Overview",
                                    size: 22,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              GridView.count(
                                shrinkWrap: true,
                                // primary: false,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: 3.2,
                                children: <Widget>[
                                  statsItems("Earned", "Rs. 230"),
                                  statsItems("Spent", "Rs. 120"),
                                  statsItems("Total Rides", "5"),
                                  statsItems("Active Rides", "1"),
                                ],
                              ),
                              Container(
                                height: 0.5,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                color: Colors.grey,
                              ),
                              CustomText(
                                  text: "Pending Clearence",
                                  size: 17,
                                  weight: FontWeight.w500),
                              CustomText(
                                  text: "Rs. 400",
                                  size: 25,
                                  weight: FontWeight.bold),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: CarouselSlider(
                            items: [
                              Image.network(
                                  "https://picsum.photos/250?image=9"),
                              Image.network(
                                  "https://picsum.photos/250?image=8"),
                              Image.network(
                                  "https://picsum.photos/250?image=7"),
                            ],
                            options: CarouselOptions(
                              // aspectRatio: 1.5,
                              enlargeCenterPage: true,
                              // enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              // height: 200,

                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 500),
                            ),
                            // carouselController: _controller,
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

  Widget percentageCircles(double percentage, String txt1, String txt2) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 54.0,
          lineWidth: 4.0,
          animation: true,
          animationDuration: 800,
          percent: percentage,
          center: Text(
            // percent.toString() + "%",
            "${(percentage * 100).toInt()}%",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          // backgroundColor: Colors.grey[300]!,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.green,
        ),
        CustomText(
          text: txt1,
          size: 15,
        ),
        CustomText(
          text: txt2,
          size: 15,
        ),
      ],
    );
  }

  Widget statsItems(String heading, String value) {
    return Container(
      // color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: heading,
          ),
          CustomText(
            text: value,
            size: 25,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
