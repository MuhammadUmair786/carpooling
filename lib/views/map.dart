// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'package:dropdown_search/dropdown_search.dart';
// import 'package:carpooling_app/widgets/custom_text.dart';
// import 'package:carpooling_app/widgets/showSnackBar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GMap extends StatefulWidget {
//   final String labelNote;

//   GMap({required this.labelNote});

//   @override
//   _GMapState createState() => _GMapState();
// }

// class _GMapState extends State<GMap> {
//   List<Marker> _markers = [];

//   final LatLng _center = const LatLng(33.578891, 73.039483);
//   LatLng? _currentCoordinates;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _center,
//                 zoom: 17.0,
//               ),
//               // compassEnabled: false,
//               markers: _markers.toSet(),
//               zoomControlsEnabled: false,
//               myLocationButtonEnabled: true,
//               myLocationEnabled: true,
//               trafficEnabled: true,
//               onTap: (cordinate) {
//                 _currentCoordinates = cordinate;
//                 // print(cordinate);
//                 setState(() {
//                   _markers = [];
//                   _markers.add(
//                     Marker(
//                       markerId: MarkerId(cordinate.toString()),
//                       position: cordinate,
//                       draggable: true,
//                       onDragEnd: (dragEndPosition) {
//                         // print(dragEndPosition.toString() + " end point");
//                       },
//                     ),
//                   );
//                 });
//               },
//             ),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Column(
//                         children: [
//                           FittedBox(
//                             fit: BoxFit.fill,
//                             child: CustomText(
//                               text: widget.labelNote,
//                               size: 40,
//                               weight: FontWeight.bold,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12)),
//                               padding: EdgeInsets.all(16),
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.location_on),
//                                   SizedBox(width: 8),
//                                   CustomText(
//                                     text: "Search a location",
//                                     size: 20,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(double.infinity, 50),
//                               primary: Colors.green,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_currentCoordinates != null) {
//                                 Get.back(result: _currentCoordinates);
//                               } else {
//                                 showErrorSnackBar();
//                               }
//                             },
//                             child: CustomText(
//                               text: "Confirm Location",
//                               size: 20,
//                               weight: FontWeight.bold,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
