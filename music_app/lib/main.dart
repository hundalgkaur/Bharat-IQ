import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/consts/colors.dart';
import 'package:music_app/views/home.dart';
import 'package:music_app/views/splash.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beats',
      theme: ThemeData(

       appBarTheme: const AppBarTheme(
         backgroundColor: bgDarkColor,
         elevation: 5,
       )
      ),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 5), () {}), // Adjust the duration
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Home(); //
          } else {
            return CustomSplashScreen();
          }
        },
      ),
    );
  }
}

