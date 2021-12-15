import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF4793E),
          title: Text("Notification Settings"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              NotificationItem(
                detail: "Allow ride confirmation notification",
                title: "Ride Notification",
              ),
              NotificationItem(
                detail: "Notify me when someone want to chat with me",
                title: "Chat",
              ),
              NotificationItem(
                detail: "Play sound for new notification",
                title: "Notification Sound",
              ),
              NotificationItem(
                detail: "Allow vibration on notification",
                title: "Vibration",
              ),
              NotificationItem(
                detail: "Allow Led blinking on notification",
                title: "Allow using LED light",
              ),
            ],
          ),
        )));
  }
}

class NotificationItem extends StatefulWidget {
  final title;
  final detail;

  const NotificationItem({@required this.title, @required this.detail});
  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
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
                  Container(child: CustomText(text: widget.detail,size: 12,)),
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
