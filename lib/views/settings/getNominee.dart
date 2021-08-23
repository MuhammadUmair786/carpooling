import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetNominee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nominee"),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: Get.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(fontSize: 16),
                  labelText: "Name",
                  // labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                // textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
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
              DropdownSearch<String>(
                // .collapsed(hintText: "Province",border: Border.),
                mode: Mode.MENU,
                // showSearchBox: true,
                showSelectedItem: true,
                maxHeight: 250,
                // popupBackgroundColor: Colors.lime,
                // searchBoxStyle:
                //     TextStyle(fontSize: 25, color: Colors.lightGreen),
                items: [
                  "Father",
                  "Mother",
                  "Brother",
                  "Sister",
                  "Husband",
                  "Wife",
                  "Son",
                  "Daughter",
                  "Uncle",
                  "Aunt",
                  "Friend"
                ],
                label: "Relation",
                onChanged: print,
                validator: (item) {
                  if (item == null)
                    return "Choose Relation";
                  else
                    return null;
                },
                // selectedItem: "Punjab",
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _phoneController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  hintStyle: TextStyle(fontSize: 16),
                  labelText: "Phone",
                  // labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
    );
  }
}
