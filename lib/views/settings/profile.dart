import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/controllers/bottomNavBarController.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/views/settings/displayName.dart';
import 'package:carpooling_app/views/settings/email_verification.dart';
import 'package:carpooling_app/views/settings/displayCNIC.dart';
import 'package:carpooling_app/views/settings/getLicense.dart';
import 'package:carpooling_app/views/settings/getWorkingDetails.dart';
import 'package:carpooling_app/views/settings/getNominee.dart';
import 'package:carpooling_app/views/settings/setDataTemplate.dart';
import 'package:carpooling_app/views/settings/uploadUserImage.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/profileItem.dart';
import 'package:carpooling_app/widgets/searchLocation.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ProfileSetting extends StatelessWidget {
  // final TextEditingController _dateController = TextEditingController();
  // final controller = Get.put(ProfileController());
  final _controller = Get.find<BottomNavBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile Setting"),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: BasicSetting(snapshotData: snapshot.data!.data()),
                  ),
                  PercentageIndicatorWidget(
                    percentage: snapshot.data!["percentage"],
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class PercentageIndicatorWidget extends StatelessWidget {
  final int percentage;
  const PercentageIndicatorWidget({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: LinearPercentIndicator(
        // width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 30.0,
        animationDuration: 2500,
        percent: percentage / 100,
        center: CustomText(
          text: "Profile Complete: $percentage %",
          weight: FontWeight.bold,
          size: 17,
          color: Colors.white,
        ),

        // Text(),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.green,
      ),
    );
  }
}

class BasicSetting extends StatelessWidget {
  final Map<String, dynamic>? snapshotData;

  const BasicSetting({Key? key, required this.snapshotData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(snapshotData!['homeAddress']['address']);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Container(
                    //   width: 90,
                    //   height: 90,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //         width: 2,
                    //         color: Theme.of(context).scaffoldBackgroundColor),
                    //     boxShadow: [
                    //       BoxShadow(
                    //           spreadRadius: 2,
                    //           blurRadius: 10,
                    //           color: Colors.black.withOpacity(0.1),
                    //           offset: Offset(0, 10))
                    //     ],
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       fit: BoxFit.cover,
                    //       image: NetworkImage(
                    //         "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    CachedNetworkImage(
                      imageUrl:
                          snapshotData!["profileImg_url"] ?? Secrets.NO_IMG,
                      // fit: BoxFit.cover,
                      // repeat: ImageR,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 2,
                      ),
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          print("upload img");
                          Get.to(() => UploadUserImage());
                        },
                        child: Container(
                          // height: 30,
                          // width: 30,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    // height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CustomText(
                                      text: snapshotData!['name'],
                                      size: 25,
                                      weight: FontWeight.bold,
                                      color: Colors.blue[300]),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() =>
                                    DisplayName(name: snapshotData!['name']));
                              },
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                              text: auth.currentUser!.phoneNumber!,

                              // .phoneNumber
                              // .toString(),
                              size: 25,
                              weight: FontWeight.bold,
                              color: Colors.blue[300]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Column(
              children: [
                ProfileItem(
                    title: "Email",
                    icon: Icons.email,
                    isAdded: auth.currentUser!.emailVerified,
                    // snapshotData!.containsKey("email"),
                    percentage: "50",
                    value: auth.currentUser!.emailVerified
                        ? auth.currentUser!.providerData[0].email.toString()
                        : "Not Added Yet",

                    // snapshotData!.containsKey("email")
                    //     ? snapshotData!["email"]
                    //     : "Not Added Yet",
                    // _controller.userfb!.email != null
                    //     ? _controller.userfb!.email.toString()
                    //     : "Not Added Yet",
                    func: () {
                      Get.to(() => EmailVerificationScreen());
                    }),
                ProfileItem(
                  title: "Home",
                  icon: Icons.home,
                  isAdded: snapshotData!.containsKey("homeAddress"),
                  percentage: "10",
                  value: snapshotData!.containsKey("homeAddress")
                      ? snapshotData!['homeAddress']['address']
                      : "Not Added Yet",
                  func: () async {
                    LatLng? homeLocation = await Get.to(
                      () => SearchLocation(),
                    );
                    String? address;
                    if (homeLocation != null) {
                      await placemarkFromCoordinates(
                              homeLocation.latitude, homeLocation.longitude)
                          .then((placemarks) {
                        address = placemarks[0].name.toString() +
                            ", " +
                            placemarks[0].subLocality.toString() +
                            ", " +
                            placemarks[0].locality.toString();
                      }).then((value) {
                        UserDatabase.addHomeAddress(
                            LatLng(
                                homeLocation.latitude, homeLocation.longitude),
                            address!);
                      });
                    }
                  },
                ),
                ProfileItem(
                    title: "Nominee",
                    icon: Icons.accessibility_new,
                    isAdded: snapshotData!.containsKey("nominee"),
                    percentage: "10",
                    value: snapshotData!.containsKey("nominee")
                        ? snapshotData!['nominee']['relation']
                        : "Not Added Yet",
                    func: () {
                      Get.to(() => GetNominee());
                    }),
                ProfileItem(
                    title: "CNIC",
                    icon: Icons.perm_identity,
                    isAdded: snapshotData!.containsKey("cnic"),
                    percentage: "10",
                    value: snapshotData!.containsKey("cnic")
                        ? snapshotData!['cnic']['cnic']
                        : "Not Added Yet",
                    func: () {
                      snapshotData!.containsKey("cnic")
                          ? showSnackBar("CNIC", "Already Added")
                          : Get.to(() => GetCNIC(isreadonly: false));
                    }),
                ProfileItem(
                    title: "License",
                    icon: Icons.card_travel,
                    isAdded: snapshotData!.containsKey("license"),
                    percentage: "10",
                    value: snapshotData!.containsKey("license")
                        ? snapshotData!['license']['license']
                        : "Not Added Yet",
                    func: () {
                      snapshotData!.containsKey("license")
                          ? showSnackBar("License", "Already Added")
                          : Get.to(() => GetCNIC(isreadonly: false));
                    }),
                ProfileItem(
                    //workingDetails
                    title: "Working Details",
                    icon: Icons.card_travel,
                    isAdded: snapshotData!.containsKey("workingDetails"),
                    percentage: "10",
                    value: snapshotData!.containsKey("workingDetails")
                        ? snapshotData!['workingDetails']['type']
                        : "Not Added Yet",
                    func: () {
                      Get.to(() => GetWorkingDetails(isreadonly: true));
                    }),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
