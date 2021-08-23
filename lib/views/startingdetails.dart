import 'package:carpooling_app/views/bottomnavbar.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

//name dob

class StartingDetails extends StatelessWidget {
  // String? dateText = "Select Date of Birth";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: Get.height / 10, horizontal: 20),
        child: Column(
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
            Expanded(
              child: TextFormField(
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
                try {
                  final DateTime? picked = (await showDatePicker(
                    // currentDate: DateTime.now(),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  ));

                  if (picked != null)
                    _dateController.text =
                        Jiffy([picked.year, picked.minute, picked.day]).yMMMMd;
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
                // Get.to(BottomNavBar());
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
    );
  }
}
