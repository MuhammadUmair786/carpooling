import 'dart:math';

import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/heplerMethods/findDistance.dart';
import 'package:carpooling_app/views/rides/search_rides_response.dart';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(31.5204, 74.3587); //31.5204° N, 74.3587
const LatLng DEST_LOCATION = LatLng(33.6844, 73.0479); //33.6844° N, 73.0479° E

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  var _originController = TextEditingController();
  var _destinationController = TextEditingController();
  late GoogleMapController _mapController;
  late Position _currentPosition;
  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = Secrets.API_KEY;

  double totalDistance = 0;

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Icon prefixIcon,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: Get.width * 0.85,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (_originController.text.isNotEmpty &&
              _destinationController.text.isNotEmpty) {
            // markers.clear();
            // _calculateDistance();
          }
        },

        controller: controller,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        // focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
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

  @override
  void initState() {
    super.initState();
    //get current location of user
    // _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            onMapCreated: onMapCreated),
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                // width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _textField(
                        label: 'Start',
                        hint: 'Choose starting point',
                        prefixIcon: Icon(
                          Icons.trip_origin,
                          color: Colors.green,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.my_location),
                          onPressed: () {
                            // startAddressController.text = _currentAddress;
                            // startAddressController.text = _currentAddress;
                          },
                        ),
                        controller: _originController,
                        // focusNode: startAddressFocusNode,
                        // width: width,
                      ),
                      // SizedBox(height: 5),
                      _textField(
                        label: 'Destination',
                        hint: 'Choose destination',
                        prefixIcon: Icon(Icons.location_on, color: Colors.red),
                        controller: _destinationController,
                      ),
                      // SizedBox(height: 10),
                      Visibility(
                        visible: totalDistance == 0 ? false : true,
                        child: Text(
                          'DISTANCE: ' +
                              totalDistance.toStringAsFixed(2) +
                              ' km',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                          onPressed: () async {
                            // Get.to(() => Search());
                            // final sessionToken = Uuid().v4();
                            // final Suggestion? result = await showSearch(
                            //   context: context,
                            //   delegate: AddressSearch(sessionToken),
                            // );
                            // if (result != null) {
                            //   print("\n\n" + result.description + "\n\n");
                            // }

                            var p = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: Secrets.API_KEY,
                              mode: Mode.overlay, // Mode.fullscreen
                              language: "eng",
                              // components: [new Component(Component.country, "fr")]
                            );
                          },
                          child: Text("Search Screen")),
                      ElevatedButton(
                        onPressed: (_originController.text.isNotEmpty &&
                                _destinationController.text.isNotEmpty)
                            ? () {
                                Get.to(() => SearchRidesResponse());
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
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      // await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  void onMapCreated(GoogleMapController controller) {
    // controller.setMapStyle(Utils.mapStyles);
    _mapController = controller;
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: SOURCE_LOCATION,
        // icon: sourceIcon
      ));
      // destination pin
      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: DEST_LOCATION,
        // icon: destinationIcon
      ));
    });
  }

  void addmarker() {}

  setPolylines() async {
    PolylineResult polyResult = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude)
        // SOURCE_LOCATION,
        // DEST_LOCATION,
        );
    if (polyResult.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      polyResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
      print("\n\n Hellow " + "\n\\n\n");

      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += getCoordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      print("\n\n" + totalDistance.toString() + "\n\\n\n");
    });
  }
}
