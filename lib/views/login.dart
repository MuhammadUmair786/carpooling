import 'package:carpooling_app/controllers/loginController.dart';
import 'package:carpooling_app/views/startingdetails.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

// https://github.com/DevStack06/Flutter-Firebase-TodoApp/tree/master/lib/pages
// https://pub.dev/packages/pin_code_fields
// check this alternative, it allow for copy also

class Login extends StatelessWidget {
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  // AuthClass authClass = AuthClass();
  // String verificationIdFinal = "";
  // String smsCode = "";
  final _controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: Get.height / 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: CustomText(
                    text: "Welcome to Carpooling App!",
                    weight: FontWeight.bold,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: CustomText(
                    text: "Sign in with One Time Password (OTP)",
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width - 20,
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo/pakflag.png',
                            width: 40,
                            height: 35,
                          ),
                          CustomText(
                            text: "   +92 ",
                            weight: FontWeight.w500,
                            color: Colors.white,
                            size: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your phone Number",
                                  hintStyle: TextStyle(
                                      color: Colors.white54, fontSize: 17),
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, bottom: 4),
                                  errorStyle: TextStyle(
                                    fontSize: 18.0,
                                  )),
                              validator: (value) {
                                if (value!.startsWith('0')) {
                                  return 'must\'nt start with 0';
                                }
                                if (value.length < 10 || value.isEmpty) {
                                  return 'Invalid';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              GetBuilder<LoginController>(builder: (cntr) {
                if (cntr.isOTP.isTrue) {
                  return Column(
                    children: [
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
                              "Enter 6 digit code",
                              style: TextStyle(fontSize: 16, color: Colors.red),
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
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 50,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        style: TextStyle(fontSize: 20),
                        onChanged: (pin) {
                          print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          CustomText(text: "Didn't recieve OTP ??"),
                          SizedBox(height: 5),
                          Obx(
                            () => _controller.timer > 0
                                ? CustomText(
                                    text:
                                        "Resend in ${_controller.timer} Seconds...",
                                    color: Colors.red,
                                    size: 20,
                                  )
                                : TextButton(
                                    style: ButtonStyle(
                                      enableFeedback: true,
                                    ),
                                    onPressed: () {},
                                    child: CustomText(
                                      text: 'Resent OTP',
                                      size: 20,
                                      weight: FontWeight.w700,
                                      color: Colors.blue,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      InkWell(
                        onTap: () {
                          // authClass.signInwithPhoneNumber(
                          //     verificationIdFinal, smsCode, context);
                          Get.to(StartingDetails());
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
                  );
                } else {
                  return ElevatedButton(
                    style: ButtonStyle(
                      enableFeedback: true,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.sentOTP(phoneController.text);
                      }
                    },
                    child: CustomText(
                      text: 'Request OTP',
                      size: 18,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
