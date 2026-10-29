

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Navigation onTap methods
  void _onHomeTap() {
    // TODO: Add your navigation code here
  }

  void _onCoursesTap() {
    // TODO: Add your navigation code here
  }

  void _onAboutTap() {
    // TODO: Add your navigation code here
  }

  void _onContactTap() {
    // TODO: Add your navigation code here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 4.0, bottom: 4.0),
          child: Image.asset(
            'assets/images/img_1.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _onHomeTap,
            child: const Text(
              "Home",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: _onCoursesTap,
            child: const Text(
              "Courses",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: _onAboutTap,
            child: const Text(
              "About Us",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: _onContactTap,
            child: const Text(
              "Contact Us",
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
