import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading() {
  Get.dialog(
    WillPopScope(
        child: Center(child: CircularProgressIndicator()),
        onWillPop: () async => false),
    barrierDismissible: false,
  );
}

dismissLoadingWidget() {
  Get.back();
}
