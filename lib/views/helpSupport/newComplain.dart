import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewComplain extends StatelessWidget {
  @override
  // int _value = 1;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF4793E),
          title: Text("Submit new request"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: "Ride ID",
                          placeholder: "e.g 142",
                          previousValue: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItem: true,
                            items: [
                              "Ride not fullfiled",
                              "Kidpnaded yoo",
                              'other'
                            ],
                            label: "Issue",
                            popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: print,
                            selectedItem: "Ride not fullfiled"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    // keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 1000,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Explain your issue'),
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Color(0xFFF4793E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: CustomText(
                      text: "Send Complain",
                      size: 20,
                      color: Colors.white,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
