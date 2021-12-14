import 'package:carpooling_app/views/rides/search_rides_response.dart';
import 'package:carpooling_app/widgets/searchLocation.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchRide extends StatefulWidget {
  @override
  _SearchRideState createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide> {
  final startAddressController = new TextEditingController();
  final endAddressController = new TextEditingController();
  bool buttonVisibility = false;

  // LatLng? _currentPoint;
  // String? _currentAddress;

  LatLng? _startPoint;

  LatLng? _endPoint;

  // _getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     _currentPoint = LatLng(position.latitude, position.longitude);
  //   }).then((value) async {
  //     await placemarkFromCoordinates(
  //             _currentPoint!.latitude, _currentPoint!.longitude)
  //         .then((placeMarkList) {
  //       Placemark place = placeMarkList[0];

  //       _currentAddress = "${place.name}, ${place.locality}";
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        // height: height,
        // width: width,
        child: Scaffold(
          body: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          _startPoint = await Get.to(
                            () => SearchLocation(),
                          );

                          if (_startPoint != null) {
                            await placemarkFromCoordinates(
                                    _startPoint!.latitude,
                                    _startPoint!.longitude)
                                .then((placemarks) {
                              startAddressController.text =
                                  placemarks[0].name.toString() +
                                      ", " +
                                      placemarks[0].subThoroughfare.toString() +
                                      ", " +
                                      placemarks[0].locality.toString();

                              if (startAddressController.text.isNotEmpty ||
                                  endAddressController.text.isNotEmpty) {
                                setState(() {
                                  buttonVisibility = true;
                                });
                              }
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: _textField(
                            hint: 'Choose starting point',
                            prefixIcon: Icon(
                              Icons.trip_origin,
                              color: Colors.green,
                            ),
                            controller: startAddressController,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _endPoint = await Get.to(
                            () => SearchLocation(),
                          );

                          if (_endPoint != null) {
                            await placemarkFromCoordinates(
                                    _endPoint!.latitude, _endPoint!.longitude)
                                .then((placemarks) {
                              endAddressController.text =
                                  placemarks[0].name.toString() +
                                      ", " +
                                      placemarks[0].subThoroughfare.toString() +
                                      ", " +
                                      placemarks[0].locality.toString();

                              if (startAddressController.text.isNotEmpty ||
                                  endAddressController.text.isNotEmpty) {
                                setState(() {
                                  buttonVisibility = true;
                                });
                              }
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: _textField(
                            // label: 'Destination',
                            hint: 'Choose destination',
                            prefixIcon:
                                Icon(Icons.location_on, color: Colors.red),
                            controller: endAddressController,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SearchRidesResponse());
                        },
                        child: Text("Temp Search Rides"),
                      ),
                      SizedBox(height: 10),
                      // Visibility(
                      //   visible: _placeDistance == null ? false : true,
                      //   child: Text(
                      //     'DISTANCE: $_placeDistance km',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: buttonVisibility
                            ? () {
                                Get.to(() => SearchRidesResponse(
                                      startPoint: _startPoint!,
                                    ));
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Show Matching Rides'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    // required String label,
    required String hint,
    required Icon prefixIcon,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width * 0.9,
      child: TextField(
        maxLines: null,
        style: TextStyle(fontSize: 18),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          // if (startAddressController.text.isNotEmpty &&
          //     endAddressController.text.isNotEmpty) {
          //   setState.call(() {});
          //   // markers.clear();
          //   // _calculateDistance();
          // }
        },

        controller: controller,
        // focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          // labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintText: hint,
        ),
      ),
    );
  }
}
