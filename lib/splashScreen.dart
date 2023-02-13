import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/LogOut.dart';
import 'package:task2/logIn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLogedIn;
  void _viewLogState() async {
    //1-Object SharedPrefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        isLogedIn = prefs.getBool("isLogedIn");
      });
      print(isLogedIn);
    }
  }

  @override
  void initState() {
    super.initState();
    _viewLogState();
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => isLogedIn == true ? LogOut() : LogIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('images/splash.jpeg'),
              radius: 150,
              // child: ,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Movie App',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
