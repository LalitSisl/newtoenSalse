import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:salesapp/utils/secure_storage.dart';

import '../Dashboard/dashboard.dart';
import 'login.dart';
// import 'package:permission_handler/permission_handler.dart' as pm;

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
    // getCoordinates();
    // startTimer();
  }

  // Future getCoordinates() async {
  //   final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
  //
  //   // var isAllowed = await UserSecureStorage().getLocationPermission();
  //
  //   final isGpsOn = serviceStatus == pm.ServiceStatus.enabled;
  //   if (!isGpsOn) {
  //     Permission.location.request();
  //     log('Turn on location services before requesting permission.');
  //     return;
  //   }
  //
  //   var status = await Permission.locationWhenInUse.request();
  //   if (status == PermissionStatus.granted) {
  //     log('Permission granted $status');
  //     // loading.value = true;
  //     log("----1-----");
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     log("$permission");
  //     if (LocationPermission.whileInUse == permission ||
  //         permission == LocationPermission.always) {
  //       log("-----2----");
  //     } else if (permission == LocationPermission.deniedForever) {
  //       log("==2--");
  //       permission = await Geolocator.requestPermission();
  //       Fluttertoast.showToast(msg: "Permission Denied, Give Permission to Location through settings");
  //     } else {
  //       permission = await Geolocator.requestPermission();
  //     }
  //   } else if (status == PermissionStatus.denied) {
  //     log("2");
  //     Fluttertoast.showToast(msg: "Current location not found, Give Permission to Location through settings");
  //
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     log("3");
  //     await openAppSettings();
  //   }
  // }

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
