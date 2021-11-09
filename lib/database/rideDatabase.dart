// import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/views/rides/rideScreen.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDatabase {
  static var rideCollection = FirebaseFirestore.instance.collection('ride');

  static Future<void> postNewRide({
    required String startingAddress,
    required LatLng startingPoints,
    required String endAddress,
    required LatLng endPoints,
    required String route,
    //ads route points or poluline later on
    required DateTime date,
    required TimeOfDay time,
    required String gender,
    required String vehicleId,
    required double vehicleMilage,
    required bool isAc,
    required String message,
    bool? isSavedTemplate,
  }) async {
    showLoading();

    // startingPoints.

    //upload cnic and img_url to user info
    rideCollection.add({
      "driverID": Get.find<AuthController>().userfb!.uid,
      "startAddress": startingAddress,
      "startPoint": GeoPoint(startingPoints.latitude, startingPoints.longitude),
      "endAddress": endAddress,
      "endPoint": GeoPoint(endPoints.latitude, endPoints.longitude),
      "route": route,
      "date": date.microsecondsSinceEpoch,
      "time": {
        "hour": time.hour,
        "minute": time.minute,
      },
      "gender": gender,
      "vehicle": {
        "id": vehicleId,
        "milage": vehicleMilage,
        "isAC": isAc,
      },
      "message": message,
      "isSaved": isSavedTemplate,
    }).then((value) {
      // print(value.id);

      rideCollection.doc(value.id).update({"id": value.id}).then((value) {
        dismissLoadingWidget();
        Get.to(() => RideScreen());
        showSnackBar("Ride Post Sucessfuly!", "");
      }).catchError((error) {
        print("Failed to Post Ride ID: $error");
        dismissLoadingWidget();
        showErrorSnackBar(
            title: "Failed to Post Ride' ", message: "Please Try again!");
      });
    }).catchError((error) {
      print("Failed to Post Ride: $error");
      dismissLoadingWidget();
      showErrorSnackBar(
          title: "Failed to Post Ride", message: "Please Try again!");
    });
  }
}
