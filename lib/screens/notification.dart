import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class Notification_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notification Screen"),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 5,
      ),
    );
  }
}
