import 'package:carpooling_app/database/userDatabase.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {
  // final _controller = Get.find<AuthController>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email"),
        elevation: 0.5,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              child: CustomText(
                text: auth.currentUser!.emailVerified
                    ? "Verified"
                    : "Pending", //verified, failed
                color: Colors.white,
              ))
        ],
      ),
      body: auth.currentUser!.emailVerified ? showEmailInfo() : linkEmail(),
    );
  }

  Widget linkEmail() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // minimumSize: Size(double.infinity, 70),
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          UserDatabase.linkEmail();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.g_mobiledata_outlined,
              size: 30,
            ),
            CustomText(
              text: "Verify Your Google Account",
              size: 16,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget showEmailInfo() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              auth.currentUser!.providerData[0].photoURL.toString(),
            ),
          ),
          SizedBox(height: 20),
          CustomText(
            text: auth.currentUser!.providerData[0].displayName.toString(),
            color: Colors.blue,
            size: 22,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(
                text: auth.currentUser!.providerData[0].email.toString(),
                size: 20,
                // color: Colors.cyan,
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomText(
            text: "DOB: 10 Dec, 1999",
            // color: Colors.blue,
            size: 22,
            weight: FontWeight.bold,
          ),

          // title: "Birthday",
          //             value: "10/12/1999",
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
