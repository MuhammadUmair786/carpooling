import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Color(0xFFF4793E),
        title: Text("Privacy Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrivacyItem(
                detail:
                    "Can everyone look up you using the phone number you provided",
                title: "Phone Number",
              ),
              PrivacyItem(
                detail:
                    "Can everyone look up you using the email address you provided",
                title: "Email",
              ),
              PrivacyItem(
                detail:
                    "Can everyone see your professional Status. i.e. Student Employee",
                title: "Details",
              ),
              PrivacyItem(
                detail: "Can everyone see your employment status details",
                title: "Employment Status",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyItem extends StatefulWidget {
  final title;
  final detail;

  const PrivacyItem({@required this.title, @required this.detail});
  @override
  _PrivacyItemState createState() => _PrivacyItemState();
}

class _PrivacyItemState extends State<PrivacyItem> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.title,
                    weight: FontWeight.bold,
                    size: 14,
                  ),
                  Container(child: CustomText(text: widget.detail,size:12)),
                ],
              ),
            ),
            SizedBox(width: 10),
            CupertinoSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            )
          ]),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
