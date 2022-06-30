// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:salesapp/showData.dart';

//import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml/xml.dart' as xml;

import 'package:xml2json/xml2json.dart';

import '../Dashboard/dashboard.dart';
import '../Network/api.dart';

class ShowDialogue extends StatefulWidget {
  const ShowDialogue({Key? key}) : super(key: key);

  @override
  State<ShowDialogue> createState() => _ShowDialogueState();
}

class _ShowDialogueState extends State<ShowDialogue> {

  bool isLoading = false;

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image;

  TextEditingController empIDController = TextEditingController();

  Widget text(String value) {
    return RichText(
      text: TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
          ),
          children: const [
            TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ))
          ]),
    );
  }

    Widget _incrementCounter(context)  {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 10,
                child:

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Creating List",
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        text(
                          "Title",
                        ),
                        Container(
                          width: 160,
                          child: TextField(
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                isDense: true,
                                contentPadding: EdgeInsets.all(10.0),
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                )),
                            controller: empIDController,
                            onTap: () {
                              // _selectDate(context,"start");
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text(
                          "Sub Title",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Container(
                          width: 160,
                          child: TextField(
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                isDense: true,
                                contentPadding: EdgeInsets.all(10.0),
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                )),
                            // controller: startdc,
                            onTap: () {
                              // _selectDate(context,"start");
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                     const Text(
                      "Capture the Picture",
                      style: TextStyle(color: Colors.blue),
                    ),

                    Container(

                        child: Column(

                            children:[

                              Container(
                                  height:200,
                                  width:200,
                                  child: controller == null?
                                  const Center(child:Text("Loading Camera...")):
                                  !controller!.value.isInitialized?
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ):
                                  CameraPreview(controller!)
                              ),

                              ElevatedButton.icon( //image capture button
                                onPressed: () async{
                                  try {
                                    if(controller != null){ //check if contrller is not null
                                      if(controller!.value.isInitialized){ //check if controller is initialized
                                        image = await controller!.takePicture(); //capture image
                                        setState(() {
                                          //update UI
                                        });
                                      }
                                    }
                                  } catch (e) {
                                    print(e); //show error
                                  }
                                },
                                icon: Icon(Icons.camera),
                                label: Text("Capture"),
                              ),

                              Container( //show captured image
                                padding: EdgeInsets.all(30),
                                child: image == null?
                                Text("No image captured"):
                                Image.file(File(image!.path), height: 200,),
                                //display captured image
                              )

                            ]
                        )

                    ),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                 var data=empIDController.text;
                                 print("data is $data");
                                 await UserSecureStorage().setData(data);

                                if(data!=null&&data.length>0){
                                  // Firebase.initializeApp();
                                  // FirebaseFirestore.instance
                                  //     .collection('eyedata')
                                  //     .add({'data': data});

                                  Fluttertoast.showToast(
                                      msg: 'Data Saved Successfully',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow
                                  );

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ShowData()));

                                }
                                else{
                                  Fluttertoast.showToast(
                                      msg: 'Please enter the Title',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow
                                  );
                                }


                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.black87),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);

                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black87),
                              ))
                        ],
                      ),
                    ),

                  ],
                ),

              ),
    );

 }

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }else{
      print("NO any camera found");
    }
  }

  initialfire() async{


    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
    initialfire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        _incrementCounter(context)



    );
  }
}
