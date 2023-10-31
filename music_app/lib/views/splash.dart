import 'package:flutter/material.dart';

class CustomSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/music.jpeg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
