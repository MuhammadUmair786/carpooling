import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DisplayName extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    bool _checkBoxValue = false;
    const _textStyle = TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.,
        // title: Text("Name"),
        // centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: CustomText(
              text: "Pending", //verified, failed
              color: Colors.red,
            ),
          )
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    fillColor: Colors.grey,
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
                SizedBox(height: 25),
                // Checkbox(value: true, onChanged: onChanged)
                CheckboxListTile(
                  title: CustomText(
                    text: "Use Email Provided Name",
                    size: 20,
                    color: Colors.blue,
                  ),
                  value: _checkBoxValue,
                  onChanged: (newValue) {
                    _checkBoxValue = !newValue!;
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width / 1.5, 40),
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {},
                    child: CustomText(
                      text: "Save Name",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
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
