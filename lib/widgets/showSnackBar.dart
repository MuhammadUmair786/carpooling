import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar({
  String title = "Oops!",
  String message = "Something wents wrong, Try Again",
}) {
  return Get.snackbar(
    "default title",
    "defalt message",
    titleText: Text(
      title,
      textScaleFactor: 1.3,
    ),
    messageText: Text(
      message,
      textScaleFactor: 1.2,
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    backgroundGradient: LinearGradient(
      colors: [Colors.red, Colors.pink.withOpacity(0.8)],
    ),
  );
}

showSnackBar(String title, String msg) {
  return Get.snackbar(
    "default title",
    "defalt message",
    titleText: Text(
      title,
      textScaleFactor: 1.3,
    ),
    messageText: Text(
      msg,
      textScaleFactor: 1.2,
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    backgroundGradient: LinearGradient(
      colors: [Colors.blue, Colors.purple.withOpacity(0.8)],
    ),
  );
}
