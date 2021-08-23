import 'package:carpooling_app/views/settings/getCNIC.dart';
import 'package:carpooling_app/views/settings/getLicense.dart';
import 'package:carpooling_app/views/settings/getWorkingDetails.dart';
import 'package:carpooling_app/views/settings/getNominee.dart';
import 'package:carpooling_app/views/settings/setDataTemplate.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/custom_text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileSetting extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile Setting"),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                // labelStyle: TextStyle(fontSize: 18),
                tabs: [
                  Tab(
                    text: "Basic",
                  ),
                  Tab(
                    text: "Verification",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BasicSetting(),
                    Security(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
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
        ),
      ),
    );
  }
}

class BasicSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 25),
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
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
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ProfileItem(
                title: "Name",
                icon: Icons.perm_identity,
                value: "Muhammad Uzair",
                func: () {
                  Get.to(() => SetDataTemplate(
                      message: "This is how your name appear on this App",
                      title: "Name",
                      keyboard: TextInputType.name));
                }),
            ProfileItem(
                title: "Birthday",
                value: "10/12/1999",
                icon: Icons.calendar_today,
                func: () {}),
            ProfileItem(
                title: "Phone No.",
                icon: Icons.phone,
                value: "+92 344 5055109",
                func: () {}),
            ProfileItem(
                title: "Email",
                icon: Icons.email,
                value: "sardarmuhammadumair786@gmail.com",
                func: () {
                  Get.to(() => SetDataTemplate(
                        message: "Enter your email",
                        title: "Email",
                        keyboard: TextInputType.emailAddress,
                      ));
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
                      ));
                }),
            ProfileItem(
                title: "Nominee",
                icon: Icons.accessibility_new,
                value: "Father",
                func: () {
                  Get.to(() => GetNominee());
                })

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
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Function() func;

  const ProfileItem(
      {required this.title,
      required this.value,
      required this.icon,
      required this.func});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.3),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            SizedBox(width: 8),
            CustomText(
              text: title,
              weight: FontWeight.bold,
              size: 20,
            ),
            Spacer(),
            if (value.isNotEmpty)
              Container(
                width: Get.width / 2,
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: value,
                    size: 20,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
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
            // CustomTextField(
            //     previousValue: "37405-9058335-5",
            //     label: "CNIC",
            //     placeholder: "placeholder",),
            // Container(
            //   height: 200,
            //   decoration:
            //       BoxDecoration(border: Border.all(color: Colors.grey)),
            //   child: Center(
            //     child: InkWell(
            //       onTap: () {},
            //       child: Container(
            //         height: 70,
            //         width: 130,
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               width: 70,
            //               child: Text("Front Side of CNIC", maxLines: 2),
            //             ),
            //             Icon(
            //               Icons.camera_enhance,
            //               size: 35,
            //               color: Colors.pink,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // CustomTextField(
            //     previousValue: "18400",
            //     label: "Liecense number",
            //     placeholder: "placeholder"),
            // DropdownSearch<String>(
            //     searchBoxDecoration:
            //         InputDecoration.collapsed(hintText: "Province"),
            //     mode: Mode.MENU,
            //     showSelectedItem: true,
            //     items: [
            //       "Punjab",
            //       "Federal",
            //       "Sindh",
            //       "KPK",
            //       "AJK",
            //       "Balochistan"
            //     ],
            //     label: "Province",
            //     popupItemDisabled: (String s) => s.startsWith('I'),
            //     onChanged: print,
            //     selectedItem: "Punjab"),
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //     height: 200,
            //     decoration:
            //         BoxDecoration(border: Border.all(color: Colors.grey)),
            //     child: Center(
            //       child: InkWell(
            //         onTap: () {},
            //         child: Container(
            //           height: 70,
            //           width: 150,
            //           padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.grey),
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                 width: 80,
            //                 child: Text("Front Side of driving licence",
            //                     maxLines: 2),
            //               ),
            //               Icon(
            //                 Icons.camera_enhance,
            //                 size: 35,
            //                 color: Colors.pink,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
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
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
