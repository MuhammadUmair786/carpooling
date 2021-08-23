import 'package:get/get.dart';
import 'dart:async';

class LoginController extends GetxController {
  var isOTP = false.obs;
  var timer = 2.obs;
  var phoneNo;

  void sentOTP(String num) {
    phoneNo = "+92" + num;
    isOTP.value = true;
    update();
    startTimmer();
  }

  void startTimmer() {
    Timer.periodic(Duration(seconds: 1), (_) {
      timer.value--;
    });
  }
}
