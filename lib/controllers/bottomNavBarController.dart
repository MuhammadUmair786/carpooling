import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController
    with WidgetsBindingObserver {
  var isback = false.obs; //is back the bottombar screen
  late PageController pageController;
  var currentIndex = 2.obs; //so that initially it comes to home
  GlobalKey bottomNavigationKey = GlobalKey();

  Rx<UserModel?> userData = Rx<UserModel?>(null);

  UserModel? get getUser => userData.value;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 2);
    WidgetsBinding.instance!.addObserver(this);
    UserDatabase.setStatus("Online");
  }

  void updatePages(int index) {
    pageController.jumpToPage(index);

    currentIndex.value = index;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    currentIndex.value = 2;
    // print("\n\n\n\n\n bottom nav bar close \n\n\n\n\n");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // online
      UserDatabase.setStatus("Online");
    } else {
      // offline
      UserDatabase.setStatus("Offline");
    }
  }
}
