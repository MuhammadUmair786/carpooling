import 'dart:io';

import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/widgets/showLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart';
// as firebase_storage;

class UserDatabase {
  static var userDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(Get.find<AuthController>().user!.uid);

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
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Details Added Sucessfuly!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Oops!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Something wents wrong, Try Again",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    });
  }

  static Future<void> addCNIC(
      {required String cnic, required File image}) async {
    showLoading();
    FirebaseStorage storage = FirebaseStorage.instance;
    // upload image and get URL

    Reference reference =
        storage.ref().child("cnic/${Get.find<AuthController>().user!.uid}");

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
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "CNIC Details Added Sucessfuly!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Wait for verification",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add cnic Details: $error");
      dismissLoadingWidget();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Oops!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Something wents wrong, Try Again",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
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

    Reference reference =
        storage.ref().child("license/${Get.find<AuthController>().user!.uid}");

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
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "License Details Added Sucessfuly!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Wait for verification",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add cnic Details: $error");
      dismissLoadingWidget();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Oops!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Something wents wrong, Try Again",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
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
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Working Details Added Sucessfuly!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
      // Get.offAll(BottomNavBar());
    }).catchError((error) {
      print("Failed to add user initial Details: $error");
      dismissLoadingWidget();
      Get.snackbar(
        "default title",
        "defalt message",
        titleText: Text(
          "Oops!",
          textScaleFactor: 1.3,
        ),
        messageText: Text(
          "Something wents wrong, Try Again",
          textScaleFactor: 1.2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.black,
        backgroundGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
        ),
      );
    });
  }
}
