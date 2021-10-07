import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/controllers/profileSettingController.dart';
import 'package:carpooling_app/views/settings/displayName.dart';
import 'package:carpooling_app/views/settings/email_verification.dart';
import 'package:carpooling_app/views/settings/displayCNIC.dart';
import 'package:carpooling_app/views/settings/getLicense.dart';
import 'package:carpooling_app/views/settings/getWorkingDetails.dart';
import 'package:carpooling_app/views/settings/getNominee.dart';
import 'package:carpooling_app/views/settings/setDataTemplate.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/profileItem.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileSetting extends StatelessWidget {
  // final TextEditingController _dateController = TextEditingController();
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile Setting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BasicSetting(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: LinearPercentIndicator(
              // width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 30.0,
              animationDuration: 2500,
              percent: 0.8,
              center: CustomText(
                text: "Profile Complete: 80%",
                weight: FontWeight.bold,
                size: 17,
                color: Colors.white,
              ),

              // Text(),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class BasicSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                InkWell(
                  onTap: () {
                    print("Open Imag");
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            print("upload img");
                          },
                          child: Container(
                            // height: 30,
                            // width: 30,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   width: 2,
                              //   color:
                              //       Theme.of(context).scaffoldBackgroundColor,
                              // ),
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
                                      text: "Muhammad Umair",
                                      size: 25,
                                      weight: FontWeight.bold,
                                      color: Colors.blue[300]),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => DisplayName());
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
                              text: Get.find<AuthController>()
                                  .user!
                                  .phoneNumber
                                  .toString(),
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
                // ProfileItem(
                //     title: "Name",
                //     icon: Icons.perm_identity,
                //     value: "Muhammad Uzair",
                //     // show option for using email provided name
                //     func: () {
                //       Get.to(() => SetDataTemplate(
                //             message:
                //                 "This is how your name appear on this App",
                //             title: "Name",
                //             keyboard: TextInputType.name,
                //             fun: () {},
                //           ));
                //     }),
                // ProfileItem(
                //     title: "Birthday",
                //     value: "10/12/1999",
                //     icon: Icons.calendar_today,
                //     func: () {}),
                // ProfileItem(
                //     title: "Phone No.",
                //     icon: Icons.phone,
                //     value: Get.find<AuthController>()
                //         .user!
                //         .phoneNumber
                //         .toString(),
                //     func: () {}),
                ProfileItem(
                    title: "Email",
                    icon: Icons.email,
                    value: Get.find<AuthController>().user!.email != null
                        ? Get.find<AuthController>().user!.email.toString()
                        : "Not Added Yet",
                    func: () {
                      Get.to(() => EmailVerificationScreen());
                    }),
                ProfileItem(
                    title: "Home",
                    icon: Icons.home,
                    value: "Faisal Colony, Street 4",
                    func: () {
                      Get.to(() => SetDataTemplate(
                            message: "Enter your email",
                            title: "Email",
                            keyboard: TextInputType.emailAddress,
                            fun: () {},
                          ));
                    }),
                ProfileItem(
                    title: "Nominee",
                    icon: Icons.accessibility_new,
                    value: "Father",
                    func: () {
                      Get.to(() => GetNominee());
                    }),
                ProfileItem(
                    title: "CNIC",
                    icon: Icons.perm_identity,
                    value: "verified",
                    func: () {
                      Get.to(() => GetCNIC(isreadonly: false));
                    }),
                ProfileItem(
                    title: "License",
                    icon: Icons.card_travel,
                    value: "unverified",
                    func: () {
                      Get.to(() => GetLicense(isreadonly: false));
                    }),
                ProfileItem(
                    title: "Working Details",
                    icon: Icons.card_travel,
                    value: "Added",
                    func: () {
                      Get.to(() => GetWorkingDetails(isreadonly: true));
                    }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          // basicProfileItem(, , ),
          // basicProfileItem("Phone No.", , () {}),
          // basicProfileItem("", , ),
          // CustomTextField(
          //     previousValue: "UZAIR",
          //     label: "First Name",
          //     placeholder: "First name"),
          // CustomTextField(
          //     previousValue: "Asghar",
          //     label: "Last Name",
          //     placeholder: "last name"),
          // CustomTextField(
          //     previousValue: "12-Aug-1998",
          //     label: "DOB",
          //     placeholder: "Date of Birth"),
          // CustomTextField(
          //     previousValue: "uk90750@gmail.com",
          //     label: "Email",
          //     placeholder: "email"),
          // CustomTextField(
          //     previousValue: "I like book reading",
          //     label: "Bio",
          //     placeholder: "Tell us something about you"),
          // SizedBox(
          //   height: 35,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     OutlineButton(
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       onPressed: () {},
          //       child: Text("CANCEL",
          //           style: TextStyle(
          //               fontSize: 14,
          //               letterSpacing: 2.2,
          //               color: Colors.black)),
          //     ),
          //     RaisedButton(
          //       onPressed: () {},
          //       color: Colors.green,
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       elevation: 2,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       child: Text(
          //         "SAVE",
          //         style: TextStyle(
          //             fontSize: 14,
          //             letterSpacing: 2.2,
          //             color: Colors.white),
          //       ),
          //     )
        ],
        // )
        // ],
      ),
    );
  }
}
