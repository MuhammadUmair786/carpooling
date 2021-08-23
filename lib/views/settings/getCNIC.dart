import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetCNIC extends StatelessWidget {
  final bool isreadonly;

  GetCNIC({required this.isreadonly});

  TextEditingController _cnicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 04,
        title: Text("CNIC Verification"),
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
                TextFormField(
                  readOnly: isreadonly,
                  controller: _cnicController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "CNIC",
                    // labelStyle: ,
                    hintText: "Enter your CNIC",
                    hintStyle: TextStyle(fontSize: 20),
                    errorStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  // textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '???';
                    }
                    //there must be space so it allow spaces
                    if (!RegExp(r'^[0-9 ]+$').hasMatch(value)) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 70,
                        width: 130,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 70,
                              child: Text(
                                "Front Side of CNIC",
                                maxLines: 2,
                              ),
                            ),
                            Icon(
                              Icons.camera_enhance,
                              size: 35,
                              color: Colors.pink,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
