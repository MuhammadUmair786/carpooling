import 'dart:io';

import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/views/vehicle/vehicle.dart';
import 'package:carpooling_app/widgets/costEstimation.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart';

class UserDatabase {
  static var userDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(Get.find<AuthController>().userfb!.uid);

  static void addNomineeDetails(
      {required String name, required String relation, required String phone}) {
    showLoading();

    userDoc.update({
      'nominee': {
        "name": name,
        "relation": relation,
        "phone": phone,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("Details Added Sucessfuly!", "");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addCNIC(
      {required String cnic, required File image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference =
        storage.ref().child("cnic/${Get.find<AuthController>().userfb!.uid}");

    UploadTask uploadTask =
        reference.putFile(image); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String cnicUrl = await taskSnapshot.ref.getDownloadURL();

    //upload cnic and img_url to user info
    userDoc.update({
      'cnic': {
        "cnic": cnic,
        "cnic_url": cnicUrl,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("CNIC Details Added Sucessfuly!", "Wait for verification");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add cnic Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static void addWorkingDetails({required Map<String, Object?> data}) {
    showLoading();
    var _tempWorkingList = [data];
    userDoc.update({
      'workingDetails': FieldValue.arrayUnion(_tempWorkingList)
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar("Working Details Added Sucessfuly!", "");
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addLicense(
      {required String area,
      required String license,
      required String vehicle,
      required File image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference = storage
        .ref()
        .child("license/${Get.find<AuthController>().userfb!.uid}");

    UploadTask uploadTask =
        reference.putFile(image); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String licenseUrl = await taskSnapshot.ref.getDownloadURL();

    //upload cnic and img_url to user info
    userDoc.update({
      'license': {
        "area": area,
        "license": license,
        "vehicle": vehicle,
        "license_url": licenseUrl,
      }
    }).then((value) {
      // print("Nominee Details Added");
      dismissLoadingWidget();
      showSnackBar(
          "License Details Added Sucessfuly!", "Wait for verification");

      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add license Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }

  static Future<void> addVehicle(
      {required String vehicleType,
      required String company,
      required String model,
      required String year,
      required String color,
      String? engineType,
      required String engine,
      required String noAlp,
      required String noNum,
      required String milage,
      required File? image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference = storage
        .ref()
        .child("vehicle/${Get.find<AuthController>().userfb!.uid}_$noNum");

    UploadTask uploadTask =
        reference.putFile(image!); //Upload the file to firebase

    TaskSnapshot taskSnapshot = await uploadTask;

    // Waits till the file is uploaded then stores the download url
    String imgUrl = await taskSnapshot.ref.getDownloadURL();

    // engineType = 1 non-hybrid
// engineType = 2 hybrid
// engineType = 3 Bike
    int sendingEngineType = 1;
    if (vehicleType == "Bike") {
      sendingEngineType = 3;
    } else if (engineType == "Hybrid") {
      sendingEngineType = 2;
    }
    double verifiedMilage = verifyMilage(
        int.parse(milage),
        sendingEngineType,
        int.parse(engine.toString().substring(0, (engine.length - 3))),
        int.parse(year));

    var _tempvehicileList = [
      {
        "id": Get.find<AuthController>().userfb!.uid.toString().substring(18),
        "vehicleType": vehicleType,
        "company": company,
        "model": model,
        "year": year,
        "color": color,
        "engineType": engineType ?? "",
        "engine": engine,
        "noAlp": noAlp,
        "noNum": noNum,
        "milage": verifiedMilage,
        "img_url": imgUrl,
      }
    ];
    // print(_tempvehicileList.toString());

    userDoc.update({
      'vehicles': FieldValue.arrayUnion(_tempvehicileList),
    }).then((value) {
      dismissLoadingWidget();
      Get.to(() => Vehicle());
      showSnackBar("Vehicle Added Sucessfuly!", "Wait for verification");
    }).catchError((error) {
      print("Failed to add Vehicle Details: $error");
      dismissLoadingWidget();
      showErrorSnackBar();
    });
  }
}
