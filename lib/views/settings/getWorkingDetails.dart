import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetWorkingDetails extends StatefulWidget {
  final bool isreadonly;

  GetWorkingDetails({required this.isreadonly});

  @override
  _GetWorkingDetailsState createState() => _GetWorkingDetailsState();
}

class _GetWorkingDetailsState extends State<GetWorkingDetails> {
  bool isStudent = false;
  bool isEmployee = false;
  bool isBusiness = false;

  Color selectedColor = Colors.blue;
  List<bool> isSelected = [false, false, false];

  TextEditingController _statusController = TextEditingController();
  //student
  TextEditingController _instController = TextEditingController();
  TextEditingController _stdAddressController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  //employee
  TextEditingController _jobNatureController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _empAddressController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  //self business
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final _stdformKey = GlobalKey<FormState>();
  final _empformKey = GlobalKey<FormState>();
  final _busiformKey = GlobalKey<FormState>();

  _clearControlers() {
    _statusController.clear();

    _addressController.clear();
    _businessNameController.clear();

    _jobNatureController.clear();
    _companyController.clear();
    _empAddressController.clear();
    _designationController.clear();

    _statusController.clear();

    _instController.clear();
    _stdAddressController.clear();

    _degreeController.clear();
  }

  _textFormFeiled(TextEditingController cont, String hint) {
    return TextFormField(
      controller: cont,
      style: TextStyle(
        fontSize: 20,
        // fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      // ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
        fillColor: Colors.grey[500],
        filled: true,
        errorStyle: TextStyle(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return '???';
        }
        return null;
      },
    );
  }

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
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          // height: Get.height -
          //     MediaQuery.of(context).padding.top -
          //     AppBar().preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  fillColor: selectedColor.withOpacity(0.2),
                  borderWidth: 5,
                  selectedBorderColor: Colors.transparent,
                  // borderRadius: BorderRadius.circular(10),
                  // renderBorder: false,
                  children: <Widget>[
                    workingTypeItem(
                        Icons.menu_book_rounded, Colors.orange, "Student"),
                    workingTypeItem(
                        Icons.emoji_people, Colors.green, "Employee"),
                    workingTypeItem(
                        Icons.business_center_rounded, Colors.red, "Business"),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                      if (index == 0) {
                        _statusController.text = "Student";
                        isStudent = true;
                        isEmployee = false;
                        isBusiness = false;
                        // widget.controller.text = "Male";
                      } else if (index == 1) {
                        _statusController.text = "Employee";
                        isStudent = false;
                        isEmployee = true;
                        isBusiness = false;
                        // widget.controller.text = "Female";
                      } else {
                        _statusController.text = "Business";
                        isStudent = false;
                        isEmployee = false;
                        isBusiness = true;
                        // widget.controller.text = "None";
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              ),
              Column(
                children: [
                  if (isStudent)
                    Form(
                      key: _stdformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Institute",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_instController,
                              "Enter your School/College/University name"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Address",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_stdAddressController,
                              "Enter your Institute Address"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Degree",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_degreeController,
                              "Enter your class/degree name"),
                        ],
                      ),
                    ),
                  if (isEmployee)
                    Form(
                      key: _empformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Job Nature",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            height: 46,
                            child: Theme(
                              data: ThemeData(
                                textTheme: TextTheme(
                                    subtitle1: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                )),
                              ),
                              child: DropdownSearch<String>(
                                // .collapsed(hintText: "Province",border: Border.),
                                popupBackgroundColor: Colors.grey[400],

                                mode: Mode.MENU,

                                dropdownSearchDecoration: InputDecoration(
                                  hintText: 'Choose nature of your Job',
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                ),
                                maxHeight: 170,
                                showSelectedItem: true,
                                items: [
                                  "Government",
                                  "Private",
                                  "MultiNational",
                                ],
                                onChanged: (value) {
                                  _jobNatureController.text = value!;
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Name",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_companyController,
                              "Enter your Company/Industry name"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Address",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_empAddressController,
                              "Enter your Company/Industry Address"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Designation",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(
                              _designationController, "Enter your designation"),
                        ],
                      ),
                    ),
                  if (isBusiness)
                    Form(
                      key: _busiformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Name",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(_businessNameController,
                              "Enter name of your Business"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CustomText(
                              text: "Address",
                              // weight: FontWeight.bold,
                              size: 22,
                              color: Colors.blue,
                            ),
                          ),
                          _textFormFeiled(
                              _addressController, "Enter your Office Address"),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width / 1.5, 40),
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          onPressed: () {
            if (isStudent && _stdformKey.currentState!.validate()) {
              UserDatabase.addWorkingDetails(data: {
                "type": "Student",
                "institute": _instController.text,
                "address": _stdAddressController.text,
                "degree": _degreeController.text,
              });
              _clearControlers();
            } else if (isEmployee && _empformKey.currentState!.validate()) {
              UserDatabase.addWorkingDetails(data: {
                "type": "Employee",
                "company_name": _companyController.text,
                "address": _empAddressController.text,
                "designation": _designationController.text,
              });
              _clearControlers();
            } else if (isBusiness && _busiformKey.currentState!.validate()) {
              UserDatabase.addWorkingDetails(data: {
                "type": "Self Business",
                "name": _businessNameController.text,
                "address": _addressController.text,
              });
              _clearControlers();
            }

            // if (_formKey.currentState!.validate() && _image != null) {
            //   UserDatabase.addLicense(
            //       area: _areaController.text,
            //       license: _licenseController.text,
            //       vehicle: _vehicleController.text,
            //       image: _image!);
            // }
            // if (_image == null) {
            //   setState(() {
            //     showImgError = true;
            //   });
            // }
          },
          child: CustomText(
            text: "Submit Details",
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container workingTypeItem(IconData icon, Color col, String title) {
    return Container(
      // height: 60,
      // width: 70,
      // margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(color: col),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: col,
            size: 35,
          ),
          CustomText(
            text: title,
            color: col,
            size: 18,
          )
        ],
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