// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  final String labelNote;

  GMap({required this.labelNote});

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  List<Marker> _markers = [];

  final LatLng _center = const LatLng(33.578891, 73.039483);
  late LatLng _currentCoordinates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 17.0,
              ),
              // compassEnabled: false,
              markers: _markers.toSet(),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              onTap: (cordinate) {
                _currentCoordinates = cordinate;
                print(cordinate);
                setState(() {
                  _markers = [];
                  _markers.add(
                    Marker(
                      markerId: MarkerId(cordinate.toString()),
                      position: cordinate,
                      draggable: false,
                      // onDragEnd: (dragEndPosition) {
                      //   // print(dragEndPosition.toString() + " end point");
                      // },
                      //LatLng(33.58038287153888, 73.04083999246359)
                      //LatLng(33.57987590040805, 73.04075449705124)
                      //LatLng(33.58069487377923, 73.03975939750671)
                      //LatLng(33.579807466060316, 73.04068811237812)
                      //LatLng(33.57894965785773, 73.04126143455505)
                      //LatLng(33.57914881760447, 73.04153434932232)
                      //LatLng(33.58044236712923, 73.04209224879742)
                      // LatLng(33.59374907545699, 73.04308567196131)
                      //LatLng(33.59463522269, 73.04457228630781)
                      //LatLng(33.59587324421964, 73.04269574582577)
                    ),
                  );
                  //   await placemarkFromCoordinates(
                  //           cordinate.latitude, cordinate.longitude)
                  //       .then((placemarks) {
                  //     // _startPointController.text =
                  //     //     placemarks[0].name.toString() +
                  //     //         ", " +
                  //     //         placemarks[0].locality.toString();
                  //     print("1");
                  //     print(placemarks[0].postalCode);
                  //     print(placemarks[0].name);
                  //     print(placemarks[0].locality);
                  //     print("2");

                  //     print(placemarks[0].subLocality);
                  //     print(placemarks[0].isoCountryCode);
                  //     print(placemarks[0].subThoroughfare);
                  //     print("3");

                  //     print(placemarks[0].thoroughfare);
                  //     print(placemarks[0].subAdministrativeArea);
                  //     print(placemarks[0].administrativeArea);
                  //   });
                });
              },
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: CustomText(
                              text: widget.labelNote,
                              size: 40,
                              weight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: "Search a location",
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Get.back(result: _currentCoordinates);
                            },
                            child: CustomText(
                              text: "Confirm Location",
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
