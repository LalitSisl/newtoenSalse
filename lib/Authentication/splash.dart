import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salesapp/utils/secure_storage.dart';

import '../Dashboard/dashboard.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 6), () => navigation());
    // startTimer();
  }

  void navigation() async {
   /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("EmpId") != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard()));
    } else {*/
    var staffId = await UserSecureStorage().getStaffId();
    if(staffId != null && staffId.toString().isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard()));
    }
    else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => const Login()));
    }
   // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpg',
        ),
      ),
    );
  }
}
