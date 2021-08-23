import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../map.dart';

class RequestRide extends StatelessWidget {
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _endPointController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final style = TextStyle(fontSize: 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Ride"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: CustomText(
                    text: "Send Request To Confirm Your Ride",
                    weight: FontWeight.bold,
                    size: 25,
                  ),
                ),
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

                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        result.latitude, result.longitude);

                    _startPointController.text = placemarks[0].name.toString() +
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
                TextFormField(
                  maxLines: null,
                  controller: _seatsController,
                  style: style,
                  decoration: decoration(
                    label: "Seats",
                    icon: Icons.airline_seat_legroom_reduced_sharp,
                    iconColor: Colors.purple,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter no. of seats you want';
                    }
                    if (!RegExp(r'^[0-9 .,]+$').hasMatch(value)) {
                      return 'Enter valid Number';
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
                      text: "Send Request",
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
