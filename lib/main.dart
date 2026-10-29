import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parwaz_driving_institute/screens/home/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Parwaz Driving school",
      home: Home(),
    );
  }
}
