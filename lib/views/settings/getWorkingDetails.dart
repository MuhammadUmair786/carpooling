import 'package:carpooling_app/controllers/profileSettingController.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetWorkingDetails extends StatelessWidget {
  final bool isreadonly;
  // final bool isStudent = false;
  // final bool isEmployee = false;
  // final TextEditingController _licenseController = TextEditingController();
  // final TextEditingController _vehicleController = TextEditingController();

  GetWorkingDetails({required this.isreadonly});

  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Working Details"),
        // centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              child: CustomText(
                text: "Pending", //verified, failed
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height -
                MediaQuery.of(context).padding.top -
                AppBar().preferredSize.height,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 25),
                //
                ////
                /////
                /////
                ///////
                /////
                /////
                /////
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                Obx(() {
                  return Column(
                    children: [
                      DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: [
                          "Student",
                          "Employee",
                          "Self-Business",
                        ],
                        label: "Status",
                        hint: "Choose your Status",
                        maxHeight: 160,
                        onChanged: (selected) {
                          if (selected == "Student") {
                            _controller.isStatus(typeID: 1);
                          } else if (selected == "Employee") {
                            _controller.isStatus(typeID: 2);
                          } else if (selected == "Self-Business") {
                            _controller.isStatus(typeID: 3);
                          }
                        },
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        // onChanged: print,
                        // selectedItem: "Employee",
                        // dropdownSearchDecoration: InputDecoration(
                        // icon: Icon(
                        //   Icons.motorcycle_sharp,
                        //   color: Colors.amber,
                        //   size: 30,
                        // ),
                        // labelStyle: TextStyle(fontSize: 20),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        //   borderRadius:
                        //       const BorderRadius.all(Radius.circular(14.0)),
                        // ),
                        // ),
                      ),
                      SizedBox(height: 15),
                      if (_controller.isStudent.isTrue)
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Institute',
                                    hintText:
                                        "Enter your School/College/University name"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Institute Address',
                                    hintText: "Enter your Institute Address"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Degree',
                                    hintText: "Enter your class/degree name"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      if (_controller.isEmployee.isTrue)
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              // SizedBox(height: 15),
                              DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItem: true,
                                items: [
                                  "Government",
                                  "Private",
                                ],
                                label: "Nature",
                                hint: "Choose the nature of your job",
                                maxHeight: 180,
                                // onChanged: (selected) {

                                // },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Company',
                                    hintText: "Enter your Company/Office name"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Address',
                                    hintText: "Enter your Company Address"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Designation',
                                    hintText:
                                        "Designation i.e. Assistant Professor, Shift Incharge"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      if (_controller.isBusiness.isTrue)
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              // SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Title',
                                    hintText: "Enter your Business Title"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Address',
                                    hintText: "Enter your Office Address"),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  //there must be space so it allow spaces
                                  if (!RegExp(r'^[0-9a-zA-Z ]+$')
                                      .hasMatch(value)) {
                                    return 'Enter valid Name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),

                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///
                ///

                /////
                /////
                /////
                ///
                ///
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Submit Details",
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




//  TextFormField(
//                   readOnly: isreadonly,
//                   controller: _licenseController,
//                   style: TextStyle(fontSize: 20),
//                   decoration: InputDecoration(
//                     hintText: 'Enter Your License number',
//                     hintStyle: TextStyle(fontSize: 16),
//                     labelText: "License",
//                     // labelStyle: TextStyle(fontSize: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(3),
//                       borderSide: BorderSide(
//                         width: 0.5,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                   ),
//                   // textCapitalization: TextCapitalization.words,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return '???';
//                     }
//                     //there must be space so it allow spaces
//                     if (!RegExp(r'^[0-9 ]+$').hasMatch(value)) {
//                       return 'Enter valid Name';
//                     }
//                     return null;
//                   },
//                 ),