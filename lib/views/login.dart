import 'package:carpooling_app/controllers/loginController.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Login extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final _controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const textFontSize = 20.0;
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
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (response) {
                      if (_formKey.currentState!.validate()) {
                        _controller
                            .sendCodeToAutoVerifyPhone(_phoneController.text);
                        FocusScope.of(context).unfocus();
                      }
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: textFontSize,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      fillColor: Colors.black45,
                      filled: true,
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 10),
                          Container(
                            width: 30,
                            child: Image.asset(
                              'assets/logo/pakflag.png',
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "+92",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            // textAlign: TextAlign.end,
                            textScaleFactor: 1.3,
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black45)),
                      hintText: "Enter your Phone no.",
                      hintStyle:
                          const TextStyle(color: Colors.white54, fontSize: 16),
                      contentPadding: const EdgeInsets.all(10),
                    ),
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
              ),
              GetBuilder<LoginController>(builder: (cntr) {
                if (cntr.isOTPScreen.isTrue) {
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
                          // if (cntr.isLoading.value) {
                          //   Center(child: CircularProgressIndicator());
                          // }
                          cntr.signInWithPhoneNumber(pin);
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
                      // InkWell(
                      //   onTap: () {
                      //     // authClass.signInwithPhoneNumber(
                      //     //     verificationIdFinal, smsCode, context);
                      //     Get.to(() => StartingDetails());
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     width: MediaQuery.of(context).size.width - 60,
                      //     decoration: BoxDecoration(
                      //         color: Color(0xffff9601),
                      //         borderRadius: BorderRadius.circular(15)),
                      //     child: Center(
                      //       child: Text(
                      //         "Lets Go",
                      //         style: TextStyle(
                      //             fontSize: 17,
                      //             color: Color(0xfffbe2ae),
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    width: Get.width / 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _controller
                              .sendCodeToAutoVerifyPhone(_phoneController.text);
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: CustomText(
                        text: 'Request OTP',
                        size: 16,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
