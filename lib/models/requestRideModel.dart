// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestModel {
  late String rideID; //get from that screen
  late String requestID;

  late String passangerID;
  late String startAddress;
  late LatLng startPoint;
  late LatLng endPoint;
  late String endAddress;
  late String message;
  late int seats;
  late DateTime requestedAt;
  late bool isConfirmed;
  late int rideCost;

  RequestModel.fromDocumentSnapshot({required Map<String, dynamic> snapshot}) {
    rideID = snapshot['rideID'];
    requestID = snapshot['requestId'];
    passangerID = snapshot['passangerID'];
    startAddress = snapshot['startAddress'];
    GeoPoint start = snapshot['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);

    endAddress = snapshot['endAddress'];
    GeoPoint end = snapshot['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);

    message = snapshot['message'];
    seats = snapshot['seats'];
    isConfirmed = snapshot['isConfirmed'];

    requestedAt = DateTime.fromMicrosecondsSinceEpoch(snapshot['requestedAt']);

    if (snapshot.containsKey('rideCost')) {
      rideCost = snapshot['rideCost'];
    }
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
