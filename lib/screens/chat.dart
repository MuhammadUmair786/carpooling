import 'package:carpooling_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chat Screen"),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: 4,
      ),
    );
  }
}
