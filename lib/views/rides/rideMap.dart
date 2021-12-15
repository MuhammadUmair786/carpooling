// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:dropdown_search/dropdown_search.dart';

import 'package:carpooling_app/constants/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideMap extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;

  // final LatLng _center = const LatLng(33.578891, 73.039483);
  // LatLng? _currentCoordinates;

  RideMap({required this.origin, required this.destination});

  @override
  State<RideMap> createState() => _RideMapState();
}

class _RideMapState extends State<RideMap> {
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  setPolylines() async {
    PolylineResult polyResult = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY,
      PointLatLng(widget.origin.latitude, widget.origin.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),

      //
      //
      //
      //
      //
      //
      //
      // polyline middle away edition
      //
      //
      //

      // wayPoints: [PolylineWayPoint(location: "33.6844,73.0479")]
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.origin,
                zoom: 15.0,
              ),
              // compassEnabled: false,
              markers: <Marker>{
                Marker(
                  markerId: MarkerId(widget.origin.toString()),
                  position: widget.origin,
                  draggable: false,
                ),
                Marker(
                  markerId: MarkerId(widget.destination.toString()),
                  position: widget.destination,
                  draggable: false,
                ),
              },
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: false,
              polylines: _polylines,
              onMapCreated: (con) {
                setPolylines();
              },
              // onTap: (cordinate) {
              //   _currentCoordinates = cordinate;
              //   // print(cordinate);
              //   // setState(() {
              //   //   _markers = [];
              //   //   _markers.add(
              //   //     Marker(
              //   //       markerId: MarkerId(cordinate.toString()),
              //   //       position: cordinate,
              //   //       draggable: true,
              //   //       onDragEnd: (dragEndPosition) {
              //   //         // print(dragEndPosition.toString() + " end point");
              //   //       },
              //   //     ),
              //   //   );
              //   // });
              // },
            ),
          ],
        ),
      ),
    );
  }
}
