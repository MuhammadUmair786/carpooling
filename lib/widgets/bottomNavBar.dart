import 'package:carpooling_app/screens/chat.dart';
import 'package:carpooling_app/screens/create_ride1.dart';
import 'package:carpooling_app/screens/home.dart';
import 'package:carpooling_app/screens/notification.dart';
import 'package:carpooling_app/screens/search_ride.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selected;

  const BottomNavBar({required this.selected});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  double _iconSize = 40;

  bool b1 = false;
  bool b2 = false;
  bool b3 = false;
  bool b4 = false;
  bool b5 = false;
  Color unSelected = Colors.amber;
  Color selected = Colors.purple;
  // Color _iconColor =
  void setButtonColors(int buttonNo) {
    setState(() {
      b1 = false;
      b2 = false;
      b3 = false;
      b4 = false;
      b5 = false;
      if (buttonNo == 1) {
        b1 = true;
      } else if (buttonNo == 2) {
        b2 = true;
      } else if (buttonNo == 3) {
        b3 = true;
      } else if (buttonNo == 4) {
        b4 = true;
      } else {
        b5 = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setButtonColors(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: _iconSize + 3,
            onPressed: () {
              setButtonColors(1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchRide()),
              );
            },
            icon: Icon(
              Icons.search_off,
              color: b1 == true ? selected : unSelected,
            ),
          ),
          IconButton(
            iconSize: _iconSize + 5,
            onPressed: () {
              setButtonColors(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateRide1()),
              );
            },
            icon: Icon(
              Icons.car_repair,
              color: b2 == true ? selected : unSelected,
            ),
          ),
          IconButton(
            iconSize: _iconSize + 20,
            onPressed: () {
              setButtonColors(3);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(
              Icons.home,
              color: b3 == true ? selected : unSelected,
            ),
          ),
          IconButton(
            iconSize: _iconSize,
            onPressed: () {
              setButtonColors(4);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()),
              );
            },
            icon: Icon(
              Icons.chat,
              color: b4 == true ? selected : unSelected,
            ),
          ),
          IconButton(
            iconSize: _iconSize,
            onPressed: () {
              setButtonColors(5);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notification_Screen()),
              );
            },
            icon: Icon(
              Icons.notifications,
              color: b5 == true ? selected : unSelected,
            ),
          )
        ],
      ),
    );
  }
}
//search Ride Home chat Notification 
// SideDrawer