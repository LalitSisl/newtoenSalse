// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import '../Dashboard/dashboard.dart';
import '../Network/api.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image;

  TextEditingController empIDController = TextEditingController();

  List myProducts = [];
var displayData;

  getTheData() async{
    setState(() async {
      displayData=await UserSecureStorage().getData();
      myProducts.add(displayData);
    });


  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    getTheData();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white,
        body:

        ListView.builder(
          itemCount: myProducts.length,
          itemBuilder: (BuildContext ctx, index) {
            // Display the list item
            return Dismissible(
              key: UniqueKey(),

              // only allows the user swipe from right to left
              direction: DismissDirection.endToStart,

              // Remove this product from the list
              // In production enviroment, you may want to send some request to delete it on server side
              onDismissed: (_) {
                setState(() {
                  myProducts.removeAt(index);
                });
              },

              // Display item's title, price...
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(myProducts[index].toString()),
                  ),
                  title: Text(myProducts[index]),

                  trailing: const Icon(Icons.arrow_back),
                ),
              ),

              // This will show up when the user performs dismissal action
              // It is a red background and a trash icon
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            );
          },
        )



    );

  }
}
