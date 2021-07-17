// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class G_Map extends StatefulWidget {
  @override
  _G_MapState createState() => _G_MapState();
}

class _G_MapState extends State<G_Map> {
  List<Marker> _markers = [];
  final LatLng _center = const LatLng(33.578891, 73.039483); //my location rwp
  late LatLng current_coordinates;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 17.0,
            ),
            markers: _markers.toSet(),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: true,
            onTap: (cordinate) {
              current_coordinates = cordinate;
              // print(cordinate);
              setState(() {
                _markers = [];
                _markers.add(
                  Marker(
                    markerId: MarkerId(cordinate.toString()),
                    position: cordinate,
                    draggable: true,
                    onDragEnd: (dragEndPosition) {
                      // print(dragEndPosition.toString() + " end point");
                    },
                  ),
                );
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    // decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  // margin: EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      if (_markers.length == 1) {
                        Navigator.pop(context, current_coordinates);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please Select The Location',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Done"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Future<void> findPlace(String placeName) async {
  //   String mapApiKey = "AIzaSyCZj3wnDfe6LMNOb3r3EGAwyFjImPDUbM4";
  //   if (placeName.length > 1) {
  //     String autoCompleteUrl =
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapApiKey&sessiontoken=1234567890";

  //     Uri uri = Uri.parse(autoCompleteUrl);
  //     var response = await http.get(uri,
  //         headers: {HttpHeaders.contentTypeHeader: "application/json"});
  //     print(response.body);
  //   }
  // }
}
