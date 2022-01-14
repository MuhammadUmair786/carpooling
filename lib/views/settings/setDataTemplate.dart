import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDataTemplate extends StatelessWidget {
  final String message;
  final String title;
  final TextInputType? keyboard;
  final TextEditingController _textController = TextEditingController();
  final Function() fun;

  SetDataTemplate({
    required this.message,
    required this.title,
    this.keyboard,
    required this.fun,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomText(
                    text: message,
                    size: 25,
                  ),
                ),
                TextFormField(
                  controller: _textController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: title,
                    hintStyle: TextStyle(fontSize: 20),
                    errorStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: keyboard ?? null,
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
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Color(0xFFF4793E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Save Changes",
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
