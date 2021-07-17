import 'dart:math';

import 'package:carpooling_app/providers/theme.dart';
import 'package:carpooling_app/screens/profile.dart';
import 'package:carpooling_app/screens/vehicle.dart';
import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Home extends StatefulWidget {
  // var app  = AppBar().;
  // double height = AppBar().preferredSize.height;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    // double height = AppBar.;
    // GoogleMapController _controller;
    // = GoogleMapController();
    // final CameraPosition _initialPosition =
    //     CameraPosition(target: LatLng(33.5787971, 73.0392253));
    // GoogleMapController? _mapController;
    // final LatLng _center = const LatLng(33.578891, 73.039483); //my location rwp
    // void _onMapCreated(GoogleMapController controller) {
    //   _mapController = controller;
    // }

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
      drawer: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    ClipOval(
                      // backgroundColor: Colors.amber,
                      // radius: 30,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=731&q=80",
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Muhammad",
                      textScaleFactor: 1.7,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.red[400],
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vehicle()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.local_car_wash),
                  SizedBox(width: 10),
                  Text(
                    "Vehicles",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.account_balance_outlined),
                  SizedBox(width: 10),
                  Text(
                    "Account",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.save_outlined),
                  SizedBox(width: 10),
                  Text(
                    "Saved Templates",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.contact_support_outlined),
                  SizedBox(width: 10),
                  Text(
                    "Customer Support",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.history),
                  SizedBox(width: 10),
                  Text(
                    "History",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.favorite_outline_sharp),
                  SizedBox(width: 10),
                  Text(
                    "Favourites",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout_sharp),
                  SizedBox(width: 10),
                  Text(
                    "Logout",
                    textScaleFactor: 1.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body:

          // GoogleMap(
          //   onMapCreated: (GoogleMapController controller) {
          //     _mapController = controller;
          //   },
          //   initialCameraPosition: CameraPosition(
          //     target: _center,
          //     zoom: 17.0,
          //   ),
          //   // myLocationEnabled: true,
          //   // trafficEnabled: true,
          //   markers: _markers.toSet(),
          //   onTap: (cordinate) {
          //     print(cordinate);
          //     // List<Placemark> placemarks = await placemarkFromCoordinates(
          //     //     cordinate.latitude, cordinate.longitude);
          //     // print(placemarks[0]);
          //     // _mapController!.animateCamera(CameraUpdate.newLatLng(cordinate));
          //     // addMarker(cordinate);
          //     // setState(() {
          //     // _markers = [];
          //     setState(() {
          //       _markers.add(
          //         Marker(
          //           markerId: MarkerId(cordinate.toString()),
          //           position: cordinate,
          //           draggable: true,
          //           onDragEnd: (dragEndPosition) {
          //             print(dragEndPosition.toString() + " end point");
          //           },
          //         ),
          //       );
          //     });
          //     // setState(() {
          //     //   print(_markers.length.toString() + "marker length ");
          //     // });
          //     // });
          //     print(_markers);
          //     // print()
          //   },
          // ),

          Container(
              child: Center(
        child: Image.network(
            "https://images.squarespace-cdn.com/content/v1/5a12cfb1cf81e08b62ab6535/1578499190047-Q2R9PDXJXX25U51GKNSV/ke17ZwdGBToddI8pDm48kPoswlzjSVMM-SxOp7CV59BZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZamWLI2zvYWH8K3-s_4yszcp2ryTI0HqTOaaUohrI8PI7Hk5b7wKtplcrxPf3ag-g6VC0ObVEO8cEICumLtlwuA/carpool.png"),
      )),
      bottomNavigationBar: BottomNavBar(
        selected: 3,
      ),
    );
  }
}


// GoogleMap(
//         initialCameraPosition: _initialPosition,
//         mapType: MapType.terrain,
//         onMapCreated: (controller) {
//           setState(() {
//             _controller = controller;
//           });
//         },
//         markers: markers.toSet(),
//         onTap: (cordinate) {
//           // _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
//           addMarker(cordinate);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // _controller.animateCamera(CameraUpdate.zoomOut());
//         },
//         child: Icon(Icons.zoom_out),
//       ),
