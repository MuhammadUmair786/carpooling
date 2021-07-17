import 'package:carpooling_app/screens/rides.dart';
import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchRide extends StatefulWidget {
  @override
  _SearchRideState createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide> {
  GoogleMapController? _mapController;
  List<Marker> _markers = [];

  final LatLng _center = const LatLng(33.578891, 73.039483); //my location rwp
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 17.0,
              ),
              myLocationEnabled: true,
              trafficEnabled: true,
              markers: _markers.toSet(),
              onTap: (cordinate) {
                print(cordinate);

                setState(() {
                  _markers.add(
                    Marker(
                      markerId: MarkerId(cordinate.toString()),
                      position: cordinate,
                      draggable: true,
                      onDragEnd: (dragEndPosition) {
                        print(dragEndPosition.toString() + " end point");
                      },
                    ),
                  );
                });
                print(_markers);
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              height: 175,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.trip_origin,
                          size: 22,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Choose starting point'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Choose Destination'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Icon(Icons.my_location_sharp),
                  //         Text("Your Location"),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Icon(Icons.location_on_outlined),
                  //         Text("Choose on Map"),
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Rides()),
          );
        },
        child: Icon(
          Icons.search,
          size: 30,
        ),
      ),
    );
  }
}
