import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';


https://github.com/DevStack06/Flutter-Firebase-TodoApp/tree/master/lib/pages
https://pub.dev/packages/pin_code_fields
check this alternative, it allow for copy also 

class Login extends StatelessWidget {
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  // AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff1d1d1d),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: phoneController,
                style: TextStyle(color: Colors.white, fontSize: 17),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your phone Number",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 15),
                      child: Text(
                        " (+92) ",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    suffixIcon: TextButton(
                      child: Text("Send"),
                      onPressed: () {
                        print("x");
                      },
                    )
                    // suffixIcon: InkWell(
                    //   onTap: wait
                    //       ? null
                    //       : () async {
                    //           // setState(() {
                    //           // start = 30;
                    //           wait = true;
                    //           buttonName = "Resend";
                    //           // });
                    //           // await authClass.verifyPhoneNumber(
                    //           //     "+91 ${phoneController.text}",
                    //           //     context,
                    //           //     setData);
                    //         },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 20, horizontal: 15),
                    //     child: Text(
                    //       buttonName,
                    //       style: TextStyle(
                    //         color: wait ? Colors.grey : Colors.white,
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  Text(
                    "Enter 6 digit OTP",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width - 34,
              fieldWidth: 58,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Color(0xff1d1d1d),
                borderColor: Colors.white,
              ),
              style: TextStyle(fontSize: 17, color: Colors.white),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
                // setState(() {
                //   smsCode = pin;
                // });
              },
            ),
            SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                ),
                // TextSpan(
                //   text: "00:$start",
                //   style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                // ),
                TextSpan(
                  text: " sec ",
                  style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                ),
              ],
            )),
            SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: () {
                // authClass.signInwithPhoneNumber(
                //     verificationIdFinal, smsCode, context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                    color: Color(0xffff9601),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Lets Go",
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
