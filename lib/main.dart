import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salesapp/Authentication/splash.dart';
import 'package:salesapp/viewsight.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    //  home:ViewSight()
    );
  }
}

