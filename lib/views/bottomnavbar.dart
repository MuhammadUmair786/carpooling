import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/views/chating/chat1.dart';

import 'package:carpooling_app/views/drawer/balance.dart';
import 'package:carpooling_app/views/drawer/favourites.dart';
import 'package:carpooling_app/views/drawer/history.dart';
import 'package:carpooling_app/views/drawer/savedTemplate.dart';
import 'package:carpooling_app/views/drawer/statistics.dart';
import 'package:carpooling_app/views/helpSupport/helpAndSupport.dart';
import 'package:carpooling_app/views/home.dart';
import 'package:carpooling_app/views/notifications.dart';
import 'package:carpooling_app/views/rides/rideScreen.dart';
import 'package:carpooling_app/views/rides/seacrh_ride.dart';
import 'package:carpooling_app/views/drawer/aboutUs.dart';
import 'package:carpooling_app/views/settings/setting.dart';
import 'package:carpooling_app/views/vehicle/vehicle.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavBarController _controller = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    const _iconsize = 35.0;
    return WillPopScope(
      onWillPop: () {
        Get.snackbar(
          "default title",
          "defalt message",
          titleText: Text(
            "Press again to exit",
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
          duration: Duration(seconds: 2),
        );
        if (_controller.isback.isFalse) {
          _controller.isback.value = true;
        } else {
          Get.back();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "carpooling",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
          backgroundColor: Colors.blue.withOpacity(0.8),

          // foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          actionsIconTheme: IconThemeData(color: Colors.white, size: 30),
          centerTitle: true,
          // backgroundColor: Colors.blue[400],
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => NotificationsScreen());
              },
              splashRadius: 25,
              splashColor: Colors.teal,
              icon: Icon(Icons.notifications),
              // size: 30,
              // color: Colors.yellow,
            ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 35),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Colors.lightGreen,

                          Colors.lightBlue,
                          // Colors.lightBlueAccent,
                          Colors.blue
                        ], // red to yellow
                        tileMode: TileMode
                            .decal, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Get.find<AuthController>()
                                    .userfb!
                                    .providerData[0]
                                    .photoURL ==
                                null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('assets/no_img.jpg'))
                            : CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  Get.find<AuthController>()
                                      .userfb!
                                      .providerData[0]
                                      .photoURL
                                      .toString(),
                                )),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: "Uzair Iqbal",
                                size: 25,
                              ),
                            ),
                            GFRating(
                              color: GFColors.SUCCESS,
                              borderColor: GFColors.SUCCESS,
                              filledIcon:
                                  Icon(Icons.star, color: GFColors.SUCCESS),
                              defaultIcon: Icon(
                                Icons.star,
                                color: GFColors.LIGHT,
                              ),
                              size: GFSize.SMALL,
                              value: 3.5,
                              onChanged: (value) {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  drawerItem(Icons.local_car_wash, "Vehicles", () {
                    Get.to(() => Vehicle());
                  }),
                  drawerItem(Icons.account_balance, "Balance", () {
                    Get.to(() => Balance());
                  }),
                  drawerItem(Icons.save, "Saved Templates", () {
                    Get.to(() => SavedTemplate());
                  }),
                  drawerItem(Icons.query_stats, "Statistics", () {
                    Get.to(() => Statistics());
                  }),
                  drawerItem(Icons.support_agent, "Help & Support", () {
                    Get.to(() => HelpAndSupport());
                  }),
                  drawerItem(Icons.history, "History", () {
                    Get.to(() => History());
                  }),
                  drawerItem(Icons.favorite, "Favourite", () {
                    Get.to(() => Favourites());
                  }),
                  drawerItem(Icons.person, "About Us", () {
                    Get.to(() => AboutUs());
                  }),
                ],
              ),
            ),
          ),
        ),

        body: SizedBox.expand(
          child: PageView(
            controller: _controller.pageController,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            children: [
              // SearchRidesResponse(),
              SearchRide(),
              RideScreen(),
              Home(),
              Chat1(),
              // Container(
              //   child: Center(
              //     child: Text(
              //       'Message',
              //       style: TextStyle(fontSize: 30),
              //     ),
              //   ),
              // ),
              Setting(),
            ],
          ),
        ),
        bottomNavigationBar:
            // Obx(() =>
            CurvedNavigationBar(
          key: _controller.bottomNavigationKey,
          index: _controller.currentIndex.value,
          height: 50.0,
          items: <Widget>[
            const Icon(Icons.search_off, size: _iconsize),
            const Icon(Icons.time_to_leave_rounded, size: _iconsize),
            const Icon(Icons.home, size: _iconsize),
            const Icon(Icons.chat, size: _iconsize),
            const Icon(Icons.settings, size: _iconsize),
          ],
          color: Colors.blue.withOpacity(0.8),
          buttonBackgroundColor: Colors
              // .transparent,
              .purple
              .withOpacity(0.1),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            _controller.updatePages(index);
          },
          letIndexChange: (index) => true,
        ),
        // ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, Function() fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            CustomText(
              text: title,
              // color: Colors.black54,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavBarController extends GetxController {
  var isback = false.obs; //is back the bottombar screen
  late PageController pageController;
  var currentIndex = 2.obs; //so that initially it comes to home
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 2);
  }

  void updatePages(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    update();
  }

  @override
  void onClose() {
    super.onClose();
    currentIndex.value = 2;
    print("\n\n\n\n\n bottom nav bar close \n\n\n\n\n");
  }
}
