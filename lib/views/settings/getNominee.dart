import 'package:carpooling_app/controllers/authController.dart';
import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetNominee extends StatefulWidget {
  @override
  State<GetNominee> createState() => _GetNomineeState();
}

class _GetNomineeState extends State<GetNominee> {
  var nomineeDetails = Get.find<AuthController>().userData!.nomineeDetails;

  late bool _readOnly;
  late bool showWidgets;
  @override
  void initState() {
    super.initState();
    if (nomineeDetails.isEmpty) {
      _readOnly = false;
      showWidgets = true;
    } else {
      _readOnly = true;
      showWidgets = false;
      _nameController.text = nomineeDetails['name'];
      _phoneController.text = nomineeDetails['phone'].toString().substring(3);
      _relationController.text = nomineeDetails['relation'];
    }
  }

  final TextEditingController _nameController = TextEditingController();
//// adjust vaue in init state
  final TextEditingController _relationController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.blue),
        // toolbarHeight : 40,
        title: CustomText(
          text: "Nominee Detail",
          size: 27,
          weight: FontWeight.bold,
          color: Colors.blue,
        ),
        actions: [
          if (_readOnly)
            IconButton(
                onPressed: () {
                  setState(() {
                    showWidgets = true;
                    _readOnly = false;
                  });
                },
                splashRadius: 20,
                icon: Icon(Icons.mode_edit_outline_outlined))
        ],
        backgroundColor: Colors.white,
        // toolbarHeight: 40,
        // centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(color: Colors.blue, width: 3),
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomText(
                  text: "Name",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                controller: _nameController,
                style: _textStyle,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                textInputAction: TextInputAction.next,
                readOnly: _readOnly,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  fillColor: Colors.grey[400],
                  errorStyle: TextStyle(fontSize: 16),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                ),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '???';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomText(
                  text: "Relation",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              InkWell(
                onTap: () async {
                  if (showWidgets)
                    Get.bottomSheet(
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 45,
                              height: 5,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(vertical: 12),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  nomineeBottomSheetItem(
                                      Colors.green, "Father"),
                                  nomineeBottomSheetItem(
                                      Colors.green, "Mother"),
                                  nomineeBottomSheetItem(
                                      Colors.green, "Brother"),
                                  nomineeBottomSheetItem(
                                      Colors.green, "Sister"),
                                  nomineeBottomSheetItem(
                                      Colors.green, "Husband"),
                                  nomineeBottomSheetItem(Colors.green, "Wife"),
                                  nomineeBottomSheetItem(Colors.green, "Son"),
                                  nomineeBottomSheetItem(
                                      Colors.green, "Daughter"),
                                  nomineeBottomSheetItem(Colors.teal, "Uncle"),
                                  nomineeBottomSheetItem(Colors.teal, "Aunt"),
                                  nomineeBottomSheetItem(Colors.teal, "Friend"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    // maxLines: null,
                    controller: _relationController,
                    style: _textStyle,
                    readOnly: _readOnly,
                    decoration: InputDecoration(
                      hintText: 'Relation',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                      fillColor: Colors.grey[400],
                      errorStyle: TextStyle(fontSize: 16),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '???';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CustomText(
                  text: "Phone Number",
                  // weight: FontWeight.bold,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                controller: _phoneController,
                maxLength: 10,
                readOnly: _readOnly,
                style: _textStyle,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                decoration: InputDecoration(
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 20,
                  ),
                  counter: showWidgets ? null : Offstage(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText(
                      text: "+92",
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  hintText: 'Enter Phone Number',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  errorStyle: TextStyle(fontSize: 16),
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '???';
                  }
                  if (value.startsWith('0')) {
                    return 'must\'nt start with 0';
                  }
                  if (value.length < 10 || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: showWidgets,
        child: Container(
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
              if (_formKey.currentState!.validate()) {
                UserDatabase.addNomineeDetails(
                    name: _nameController.text,
                    relation: _relationController.text,
                    phone: "+92" + _phoneController.text);
              }
            },
            child: CustomText(
              text: "Save Details",
              size: 20,
              // weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  InkWell nomineeBottomSheetItem(Color col, String title) {
    return InkWell(
      onTap: () {
        _relationController.text = title;
        Get.back();
      },
      splashColor: col.withOpacity(0.5),
      child: Container(
        decoration: new BoxDecoration(
          color: col.withOpacity(0.2),
          border: Border(
            bottom: BorderSide(color: col, width: 3),
          ),
        ),
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: CustomText(
          text: title,
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
