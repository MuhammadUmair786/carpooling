import 'dart:math';

import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/database/rideDatabase.dart';
import 'package:carpooling_app/heplerMethods/findDistance.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/views/drawer/savedTemplate.dart';
import 'package:carpooling_app/views/map.dart';
import 'package:carpooling_app/widgets/costEstimation.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';

class PostRide extends StatefulWidget {
  RideModel? templateRide;

  PostRide({RideModel? this.templateRide});

  @override
  State<PostRide> createState() => _PostRideState();
}

class _PostRideState extends State<PostRide> {
  @override
  void initState() {
    super.initState();
    if (widget.templateRide != null) {
      _startPointController.text = widget.templateRide!.startingAddress;
      startPoint = widget.templateRide!.startPoint;
      _endPointController.text = widget.templateRide!.endAddress;
      endPoint = widget.templateRide!.endPoint;
      _routeController.text = widget.templateRide!.route;
      date = widget.templateRide!.startDate;
      _dateController.text = Jiffy(date).yMMMMd;
      time = widget.templateRide!.time;
      _timeController.text = "${time.hour}:${time.minute} ${time.hourOfPeriod}";
      _genderController.text = widget.templateRide!.gender;
      for (int i = 0; i < vehicleList.length; i++) {
        if (vehicleList[i]['id'] == widget.templateRide!.vehicleId) {
          _vehicleController.text = vehicleList[i]['model'] +
              " (" +
              vehicleList[i]['noAlp'] +
              " " +
              vehicleList[i]['noNum'] +
              ")";
        }
      }
      // _vehicleController.text = vehicleList.where((element) {
      //   element[''] == widget.templateRide!.vehicleId;
      // }).toString();
      vehicleId = widget.templateRide!.vehicleId;
      vehicleImgUrl = widget.templateRide!.vehicleImg;
      vehicleMilage = widget.templateRide!.vehicleMilage;
      isAC = widget.templateRide!.isAc;
      _messageController.text = widget.templateRide!.message;
    }
  }

  final TextEditingController _startPointController = TextEditingController();

  final TextEditingController _endPointController = TextEditingController();

  final TextEditingController _routeController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  late DateTime date;

  final TextEditingController _timeController = TextEditingController();
  late TimeOfDay time;

  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _vehicleController = TextEditingController();

  late String vehicleId;
  late String vehicleImgUrl;
  late double vehicleMilage;
  bool isAC = false;

  final TextEditingController _messageController = TextEditingController();

  final style = TextStyle(fontSize: 22, color: Colors.white);

  late LatLng? startPoint;

  late LatLng? endPoint;

  late double distance;

  final _formKey = GlobalKey<FormState>();

  var vehicleList = Get.find<AuthController>().userData!.vehicleList;

  InputDecoration decoration({
    String? hint,
    String? label,
    required IconData icon,
    Color? iconColor,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
      fillColor: Colors.grey[500],
      filled: true,
      errorStyle: TextStyle(fontSize: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),

      // border: UnderlineInputBorder(),
      // hintText: hint,
      // hintStyle: style, //final feild in Parent
      labelText: label,
      labelStyle: TextStyle(fontSize: 22, color: Colors.black),
      prefixIcon: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      // errorStyle: TextStyle(
      //   fontSize: 18.0,
      // ),
    );
  }

  final makeListTile = ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      // alignment: Alignment.topLeft,
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.autorenew, color: Colors.white),
    ),
    title: Text(
      "Introduction to Driving",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

    subtitle: TextField(
      maxLines: null,
    ),
    // Row(
    //   children: <Widget>[
    //     Icon(Icons.linear_scale, color: Colors.yellowAccent),
    //     Text(" Intermediate", style: TextStyle(color: Colors.white))
    //   ],
    // ),
    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
  );

  @override
  Widget build(BuildContext context) {
    _genderController.text = "None"; //default
    const double gapHeight = 10;
    return Scaffold(
      appBar: AppBar(
        title: Text("Set & Go"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SavedTemplate());
            },
            splashRadius: 25,
            splashColor: Colors.teal,
            icon: Icon(Icons.save),
            // size: 30,
            // color: Colors.yellow,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10),
                  // InkWell(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: Icon(Icons.arrow_back_ios_new_rounded)),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: CustomText(
                      text: "Set Up Your Ride",
                      weight: FontWeight.bold,
                      size: 35,
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.person),
                  //   title: CustomText(text: "Starting Point"),
                  //   subtitle: TextField(
                  //     maxLines: null,
                  //   ),
                  // ),
                  rideItem(),
                  SizedBox(
                    height: 23,
                  ),
                  // if (widget.rideType != 1)
                  InkWell(
                    onTap: () async {
                      startPoint = await Get.to(
                        () => GMap(
                          labelNote: "Origin Of Your Ride",
                        ),
                      );

                      // _startPointController.text = await getAddress(startPoint);
                      if (startPoint != null) {
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                startPoint!.latitude, startPoint!.longitude);

                        _startPointController.text =
                            placemarks[0].name.toString() +
                                ", " +
                                placemarks[0].locality.toString() +
                                ", " +
                                placemarks[0].country.toString();
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _startPointController,
                        style: style,
                        decoration: decoration(
                          label: "Starting Point",
                          icon: Icons.trip_origin_rounded,
                          iconColor: Colors.blue,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must Enter Starting Point';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  InkWell(
                    onTap: () async {
                      endPoint = await Get.to(
                          GMap(labelNote: "Destination Of Your Ride"));

                      if (endPoint != null) {
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                endPoint!.latitude, endPoint!.longitude);

                        _endPointController.text =
                            placemarks[0].name.toString() +
                                ", " +
                                placemarks[0].locality.toString() +
                                ", " +
                                placemarks[0].country.toString();
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _endPointController,
                        style: style,
                        decoration: decoration(
                          label: "Destination",
                          icon: Icons.location_on,
                          iconColor: Colors.red,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must Enter Ending Point';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // InkWell(
                  //   onTap: () {},
                  //   // child: AbsorbPointer(
                  //   child:

                  TextFormField(
                    maxLines: null,
                    controller: _routeController,
                    style: style,
                    decoration: decoration(
                      label: "Route",
                      icon: Icons.alt_route,
                      iconColor: Colors.yellow,
                    ),
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Select Your Route';
                      }
                      return null;
                    },
                  ),
                  // ),
                  // ),
                  SizedBox(height: gapHeight),
                  // if (widget.rideType != 1)
                  InkWell(
                    onTap: () async {
                      try {
                        date = (await showDatePicker(
                          // currentDate: DateTime.now(),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 15)),
                        ).then((value) {
                          _dateController.text = Jiffy([value]).yMMMMd;
                        }))!;

                        // if (date != null)
                        //   _dateController.text =
                        //       Jiffy([date]).yMMMMd;
                      } catch (ex) {
                        print(ex);
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _dateController,
                        style: style,
                        decoration: decoration(
                          label: "Date",
                          icon: Icons.date_range,
                          iconColor: Colors.brown,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the date of your departure';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  // if (widget.rideType != 1)
                  InkWell(
                    onTap: () async {
                      try {
                        time = (await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ))!;
                        if (time != null) {
                          _timeController.text = time.format(context);
                        }
                      } catch (ex) {
                        print(ex);
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _timeController,
                        style: style,
                        decoration: decoration(
                          label: "Time",
                          icon: Icons.access_time,
                          iconColor: Colors.red,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the time of your departure';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  InkWell(
                    onTap: () async {
                      Get.bottomSheet(
                        SafeArea(
                          child: Container(
                            height: 200,
                            child: Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 5,
                                  color: Colors.grey,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  child: Column(
                                    children: [
                                      CustomText(text: "Gender Preference"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          genderBottomSheetItem(Icons.male,
                                              Colors.blue, " Male "),
                                          genderBottomSheetItem(Icons.female,
                                              Colors.green, "Female"),
                                          genderBottomSheetItem(Icons.block,
                                              Colors.red, " None "),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _genderController,
                        style: style,
                        decoration: decoration(
                          label: "Gender Preference",
                          icon: Icons.male_sharp,
                          iconColor: Colors.teal,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Enter the time of your departure';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  InkWell(
                    onTap: () async {
                      Get.bottomSheet(
                        SafeArea(
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 5,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              Container(
                                // height: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "Choose Your Vehicle",
                                        size: 22,
                                        weight: FontWeight.bold,
                                      ),
                                      ListView.builder(
                                          itemCount: vehicleList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (con, index) {
                                            return bottomSheetVehicleItem(
                                                vehicleList[index]["id"],
                                                vehicleList[index]["img_url"],
                                                vehicleList[index]["model"],
                                                vehicleList[index]["year"],
                                                vehicleList[index]["noAlp"] +
                                                    " " +
                                                    vehicleList[index]["noNum"],
                                                vehicleList[index]["milage"]);
                                          }),

                                      // bottomSheetVehicleItem(
                                      //     "Corolla", "2018", "RIW-2981", 12),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        maxLines: null,
                        controller: _vehicleController,
                        style: style,
                        decoration: decoration(
                          label: "Vehicle",
                          icon: Icons.time_to_leave,
                          iconColor: Colors.yellow,
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Choose Your Vehicle!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  // Container(
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[500],
                  //       borderRadius: BorderRadius.circular(10)),
                  //   alignment: Alignment.centerLeft,
                  //   child:
                  CheckboxListTile(
                    title: CustomText(
                      text: "AC/Heater",
                      size: 20,
                      weight: FontWeight.bold,
                      // color: Colors.wh,
                    ),
                    value: isAC,
                    onChanged: (newValue) {
                      setState(() {
                        isAC = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  // ),
                  SizedBox(height: gapHeight),
                  TextFormField(
                    maxLines: null,
                    controller: _messageController,
                    style: style,
                    decoration: decoration(
                      label: "Message",
                      icon: Icons.message,
                      iconColor: Colors.tealAccent,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    // keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Choose Your Vehicle!';
                      }
                      return null;
                    },
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width / 2.5, 40),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        distance =

                            // Geolocator.distanceBetween
                            getCoordinateDistance(
                                startPoint!.latitude,
                                startPoint!.longitude,
                                endPoint!.latitude,
                                endPoint!.longitude);
                        if (_formKey.currentState!.validate()) {
                          Get.bottomSheet(
                            SafeArea(
                              child: Container(
                                height: 180,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 5,
                                      color: Colors.grey,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    Container(
                                      // height: 200,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text:
                                                  "Distance : ${distance.toStringAsFixed(1)} KM",
                                              // "Distance = 23KM",
                                              size: 22,
                                              weight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                            SizedBox(height: 10),
                                            CustomText(
                                              text:
                                                  "Ride Cost : RS ${estimateCost(distance, vehicleMilage,
                                                      // adjust milage
                                                      isAC).toStringAsFixed(0)}",
                                              // "Ride cost:  450 RS",
                                              size: 22,
                                              weight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: Size(120, 40),
                                                    primary: Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    _postRide(true);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.save_rounded),
                                                      CustomText(
                                                          text: " Save & Post ",
                                                          size: 18,
                                                          weight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                      Icon(Icons.post_add),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: Size(80, 40),
                                                    primary: Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    _postRide(false);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CustomText(
                                                          text: "Post  ",
                                                          size: 18,
                                                          weight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                      Icon(Icons.post_add),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                          );
                        }
                      },
                      child: CustomText(
                        text: "Next",
                        size: 20,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  _postRide(bool isSave) {
    RideDatabase.postNewRide(
      startingAddress: _startPointController.text,
      startingPoints: startPoint!,
      endAddress: _endPointController.text,
      endPoints: endPoint!,
      route: _routeController.text,
      date: date,
      time: time,
      gender: _genderController.text,
      vehicleId: vehicleId,
      vehicleMilage: vehicleMilage,
      vehicleImg: vehicleImgUrl,
      isAc: isAC,
      message: _messageController.text,
      isSavedTemplate: isSave,
    );
  }

  Card rideItem() {
    return Card(
      elevation: 8.0,
      // margin:
      //     new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            // alignment: Alignment.topLeft,
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            "Introduction to Driving",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: TextField(
            maxLines: null,
          ),
          // Row(
          //   children: <Widget>[
          //     Icon(Icons.linear_scale, color: Colors.yellowAccent),
          //     Text(" Intermediate", style: TextStyle(color: Colors.white))
          //   ],
          // ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        ),
      ),
    );
  }

  InkWell bottomSheetVehicleItem(String id, String? imgUrl, String company,
      String model, String number, double milage) {
    return InkWell(
      onTap: () {
        _vehicleController.text = company + " (" + number + ")";
        vehicleId = id;
        vehicleMilage = milage;
        vehicleImgUrl = imgUrl!;
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                imgUrl ??
                    "https://images.unsplash.com/photo-1612997951749-ae9c3fffaef3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: company + " " + model,
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.brown,
                ),
                SizedBox(height: 5),
                CustomText(
                  text: number,
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.blue,
                )
              ],
            ),
            Spacer(),
            Container(
              decoration: new BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 2.5,
                ),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomText(
                    text: milage.toStringAsFixed(1),
                    // color: col,
                  ),
                  CustomText(
                    text: "KM/L",
                    size: 12,
                    color: Colors.green,
                    // color: col,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell genderBottomSheetItem(IconData icon, Color col, String title) {
    return InkWell(
      onTap: () {
        _genderController.text = title;
        Get.back();
      },
      splashColor: col.withOpacity(0.5),
      child: Container(
        decoration: new BoxDecoration(
          border: Border.all(color: col, width: 3.5),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(
              icon,
              color: col,
              size: 30,
            ),
            CustomText(
              text: title,
              color: col,
            )
          ],
        ),
      ),
    );
  }
}
//  decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(fontSize: 16, color: Colors.white),
//         fillColor: Colors.grey[500],
//         filled: true,
//         errorStyle: TextStyle(fontSize: 18),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//       )
