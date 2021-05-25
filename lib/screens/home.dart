import 'dart:math';

import 'package:carpooling_app/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  // var app  = AppBar().;
  // double height = AppBar().preferredSize.height;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // double height = AppBar.;
    // GoogleMapController _controller = GoogleMapController();

    final CameraPosition _initialPosition =
        CameraPosition(target: LatLng(33.5787971, 73.0392253));

    final List<Marker> markers = [];

    addMarker(cordinate) {
      int id = Random().nextInt(100);

      setState(() {
        markers.add(
            Marker(position: cordinate, markerId: MarkerId(id.toString())));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Uzair Iqbal"),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.all(9),
              child: Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.all(10),
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ))),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.terrain,
        onMapCreated: (controller) {
          setState(() {
            // _controller = controller;
          });
        },
        markers: markers.toSet(),
        onTap: (cordinate) {
          // _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _controller.animateCamera(CameraUpdate.zoomOut());
      //   },
      //   child: Icon(Icons.zoom_out),
      // ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  double _iconSize = 40;
  // Color _iconColor =
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              iconSize: _iconSize,
              icon: Icon(
                Icons.car_rental,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                print("");
              }),
          Icon(
            Icons.car_rental,
          ),
          Icon(
            Icons.chat,
            size: _iconSize,
          ),
          Icon(
            Icons.home,
            size: _iconSize,
          ),
          Icon(
            Icons.notifications,
            size: _iconSize,
          ),
          Icon(
            Icons.settings,
            size: _iconSize,
          )
        ],
      ),
    );
  }
}
