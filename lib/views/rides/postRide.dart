import 'package:carpooling_app/views/map.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';

class PostRide extends StatelessWidget {
  final int rideType;

  PostRide({required this.rideType});
  //1: quickRide 2:Schedule Ride
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _endPointController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final style = TextStyle(fontSize: 22);

  @override
  Widget build(BuildContext context) {
    _genderController.text = "None"; //default
    return Scaffold(
      appBar: AppBar(
        title: Text("Set & Go"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.save,
              size: 30,
              color: Colors.pink,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: CustomText(
                    text: "Set Up Your Ride",
                    weight: FontWeight.bold,
                    size: 35,
                  ),
                ),
                if (rideType != 1)
                  InkWell(
                    onTap: () async {
                      LatLng result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GMap(
                            labelNote: "Origin Of Your Ride",
                          ),
                        ),
                      );

                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              result.latitude, result.longitude);

                      _startPointController.text =
                          placemarks[0].name.toString() +
                              ", " +
                              placemarks[0].locality.toString() +
                              ", " +
                              placemarks[0].country.toString();
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
                InkWell(
                  onTap: () async {
                    // LatLng result = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => GMap(
                    //       labelNote: "Destination Of Your Ride",
                    //     ),
                    //   ),
                    // );

                    LatLng? result = await Get.to(
                        GMap(labelNote: "Destination Of Your Ride"));

                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        result!.latitude, result.longitude);

                    _endPointController.text = placemarks[0].name.toString() +
                        ", " +
                        placemarks[0].locality.toString() +
                        ", " +
                        placemarks[0].country.toString();
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
                InkWell(
                  onTap: () {},
                  child: AbsorbPointer(
                    child: TextFormField(
                      maxLines: null,
                      controller: _routeController,
                      style: style,
                      decoration: decoration(
                        label: "Route",
                        icon: Icons.alt_route,
                        iconColor: Colors.yellow,
                      ),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Select Your Route';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                if (rideType != 1)
                  InkWell(
                    onTap: () async {
                      try {
                        final DateTime? picked = (await showDatePicker(
                          // currentDate: DateTime.now(),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        ));

                        if (picked != null)
                          _dateController.text =
                              Jiffy([picked.year, picked.minute, picked.day])
                                  .yMMMMd;
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
                if (rideType != 1)
                  InkWell(
                    onTap: () async {
                      try {
                        final TimeOfDay? picked = (await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ));
                        if (picked != null) {
                          _timeController.text = picked.format(context);
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
                InkWell(
                  onTap: () async {
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
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      genderBottomSheetItem(
                                          Icons.male, Colors.blue, " Male "),
                                      genderBottomSheetItem(
                                          Icons.female, Colors.green, "Female"),
                                      genderBottomSheetItem(
                                          Icons.block, Colors.red, " None "),
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
                        )));
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
                                height: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      bottomSheetVehicleItem(
                                          "Corolla", "2018", "RIW-2981", 12),
                                      bottomSheetVehicleItem(
                                          "Mehran", "2013", "JKI-2981", 18),
                                      bottomSheetVehicleItem(
                                          "Honda-70", "2014", "RIW-2981", 32),
                                      bottomSheetVehicleItem(
                                          "Mehran", "2013", "JKI-2981", 18),
                                      bottomSheetVehicleItem(
                                          "Honda-70", "2014", "RIW-2981", 32)
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
                        )));
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      //
                    },
                    child: CustomText(
                      text: "Post",
                      size: 20,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // CustomText(text: "Gender Preference"),
                // CustomText(text: "Choose vehicle"),
                // CustomText(text: "Any Message"),
                // CustomText(text: "save template icon button "),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell bottomSheetVehicleItem(
      String company, String model, String number, int milage) {
    return InkWell(
      onTap: () {
        _vehicleController.text = company + " " + number;
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
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
                    text: milage.toString(),
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

  InputDecoration decoration({
    String? hint,
    String? label,
    required IconData icon,
    Color? iconColor,
  }) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      hintText: hint,
      hintStyle: style, //final feild in Parent
      labelText: label,
      labelStyle: style,
      prefixIcon: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      errorStyle: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}
