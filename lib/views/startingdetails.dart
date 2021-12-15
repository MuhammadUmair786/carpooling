import 'package:carpooling_app/controllers/loginController.dart';
import 'package:carpooling_app/database/userDatabase.dart';
// import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

//name dob

class StartingDetails extends StatelessWidget {
  // String? dateText = "Select Date of Birth";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final LoginController _controller = LoginController();
  late final DateTime? pickedDOB;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height -
                  MediaQuery.of(context).padding.top -
                  AppBar().preferredSize.height,
              padding: EdgeInsets.symmetric(
                  vertical: Get.height / 10, horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: CustomText(
                        text: "What is your name?",
                        size: 25,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      maxLength: 30,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Name",
                        hintStyle: TextStyle(fontSize: 20),
                        errorStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '???';
                        }
                        //there must be space so it allow spaces
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Enter valid Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: CustomText(
                        text: "When were you born?",
                        size: 25,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        // print("vsdvsd");
                        try {
                          pickedDOB = (await showDatePicker(
                            // currentDate: DateTime.now(),
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 17),
                            firstDate: DateTime(1947),
                            lastDate: DateTime.now(),
                          ))!;
                          if (pickedDOB != null) {
                            _dateController.text = Jiffy(pickedDOB
                                    // .year,
                                    // pickedDOB.month,
                                    // pickedDOB.day
                                    )
                                .yMMMMd;
                          }
                        } catch (ex) {
                          print(ex);
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dateController,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Select Date",
                              hintStyle: TextStyle(fontSize: 20),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.date_range_outlined),
                              ),
                              errorStyle: TextStyle(
                                fontSize: 18.0,
                              )),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Select Your DOB !!!';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // authClass.signInwithPhoneNumber(
                        //     verificationIdFinal, smsCode, context);
                        if (_formKey.currentState!.validate()) {
                          UserDatabase.createUserDocument(
                              _nameController.text, pickedDOB!);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            color: Color(0xffff9601),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xfffbe2ae),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
