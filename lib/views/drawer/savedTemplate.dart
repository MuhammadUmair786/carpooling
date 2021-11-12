import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/database/rideDatabase.dart';
import 'package:carpooling_app/models/rideModel.dart';
import 'package:carpooling_app/views/rides/postRide.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class SavedTemplate extends StatelessWidget {
  final rideList =
      Get.find<AuthController>().userData!.postedRidesList as List<RideModel>;

  @override
  Widget build(BuildContext context) {
    rideList.removeWhere((item) => item.isSavedTemplate == false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Saved Templates"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // templateItem(),
                // templateItem(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: rideList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (cont, index) {
                      return templateItem(
                        rideList[index],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget templateItem(RideModel ride) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostRide(templateRide: ride));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 6),
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
            SizedBox(
              height: 35,
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Saved: ${Jiffy(ride.postedDate).fromNow()}",
                      size: 15,
                      weight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    IconButton(
                        onPressed: () {
                          RideDatabase.removeFromTemplate(documentID: ride.id);
                        },
                        splashRadius: 15,
                        // splashColor: Colors.amber,
                        icon: Icon(Icons.delete_forever_rounded)),
                  ],
                ),
              ),
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
                    startEndItem(Icons.trip_origin, ride.startingAddress),
                    SizedBox(height: 5),
                    startEndItem(Icons.location_on, ride.endAddress),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl: ride.vehicleImg,
                  // fit: BoxFit.cover,
                  // repeat: ImageR,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2,
                  ),
                  // placeholder: (context, url) => CircularProgressIndicator(),

                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
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
          width: Get.width / 1.9,
          child: Text(
            locationName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.justify,
            // textScaleFactor: 1.2,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18,
                // fontWeight: FontWeight.,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}
