import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/views/rides/postRide.dart';
import 'package:carpooling_app/views/rides/postedRideInfo.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_car),
                  child: Text("Posted"),
                ),
                Tab(
                  icon: Icon(Icons.request_page_sharp),
                  child: Text("Requested"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostedRides(),
                  RequestedRides(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostedRides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var rideList = Get.find<AuthController>().userData!.postedRidesList;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    barrierColor: Colors.grey.withOpacity(0.8),
                    context: context,
                    builder: (_) => dioloadChild(),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.add_box,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "Add new Ride",
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 12,
                  itemBuilder: (cont, index) {
                    return postedRideItem();
                  }),
              // postedRideItem(),
              // postedRideItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierColor: Colors.grey.withOpacity(0.8),
            context: context,
            builder: (_) => dioloadChild(),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Container dioloadChild() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shape: CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.back();
                Get.to(() => PostRide(rideType: 1));
              },
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  Icons.quick_contacts_mail,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          CustomText(
            text: "Quick Ride",
            color: Colors.white,
            weight: FontWeight.bold,
            size: 23,
          ),
          SizedBox(height: 10),
          Material(
            shape: CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.back();
                Get.to(() => PostRide(rideType: 2));
              },
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          CustomText(
            text: "Schedule Ride",
            color: Colors.white,
            weight: FontWeight.bold,
            size: 23,
          ),
        ],
      ),
    );
  }

  Widget postedRideItem() {
    return InkWell(
      onTap: () {
        // Get.to(() => PostedRideInfo());
      },
      child: Container(
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Posted: Yesterday, 8:50 PM",
              size: 15,
              weight: FontWeight.bold,
              color: Colors.blue,
            ),
            Container(
              color: Colors.grey,
              height: 0.5,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    startEndItem(Icons.trip_origin, "Faisal Colony"),
                    SizedBox(height: 5),
                    startEndItem(Icons.location_on, "Comsats University"),
                  ],
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      NetworkImage("https://picsum.photos/250?image=9"),
                )
              ],
            ),
            Container(
              color: Colors.grey,
              height: 0.5,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.visibility_sharp),
                CustomText(text: "23"),
                Container(
                  color: Colors.grey,
                  width: 1,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 20,
                ),
                Icon(Icons.outbond_sharp),
                CustomText(text: "45"),
                Spacer(),
                CustomText(
                  text: "Expired: Today, 6:50 AM",
                  size: 15,
                  weight: FontWeight.bold,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row startEndItem(IconData ic, String locationName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(ic),
        SizedBox(width: 5),
        Container(
          alignment: Alignment.topLeft,
          width: Get.width / 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: locationName,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class RequestedRides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            requestedRideItem(),
            requestedRideItem(),
          ],
        ),
      ),
    );
  }

  Container requestedRideItem() {
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Requested: Yesterday, 8:50 PM",
            size: 15,
            weight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  startEndItem(Icons.trip_origin, "Faisal Colony"),
                  SizedBox(height: 5),
                  startEndItem(Icons.location_on, "Comsats University"),
                ],
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
              )
            ],
          ),
          Container(
            color: Colors.grey,
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            children: [
              CustomText(text: "Pending"),
              Spacer(),
              CustomText(
                text: "Expired: Today, 6:50 AM",
                size: 15,
                weight: FontWeight.bold,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row startEndItem(IconData ic, String locationName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(ic),
        SizedBox(width: 5),
        Container(
          alignment: Alignment.topLeft,
          width: Get.width / 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: locationName,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
