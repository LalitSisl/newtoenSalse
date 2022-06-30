// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:salesapp/showData.dart';
import 'package:salesapp/showDialogue.dart';

//import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml/xml.dart' as xml;

import 'package:xml2json/xml2json.dart';

import '../Dashboard/dashboard.dart';
import '../Network/api.dart';

class ViewSight extends StatefulWidget {
  const ViewSight({Key? key}) : super(key: key);

  @override
  State<ViewSight> createState() => _ViewSightState();
}

class _ViewSightState extends State<ViewSight> {
  final _formKey = GlobalKey<FormState>();
  final _empIdController = TextEditingController(text: "admin");
  final _passwordController = TextEditingController(text: "babg11");
  bool isLoading = false;

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image;

  initialfire() async{


    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();



  }

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

    Future _incrementCounter(context) async {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child:  Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 10,
              child:

              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
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
                      Text(
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
                   Text(
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
                                Center(child:Text("Loading Camera...")):
                                !controller!.value.isInitialized?
                                Center(
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
        });
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
        Padding(
          padding:  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
          child: ElevatedButton.icon( //image capture button
            onPressed: () async{
              try {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowDialogue()));;
              } catch (e) {
                print(e); //show error
              }
            },
            icon: Icon(Icons.camera),
            label: Text(" Add Info "),
          ),
        ),

        // Center(
        //   child:

          // Card(
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15.0)),
          //   elevation: 10,
          //   child:
          //
          //         Column(
          //
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Creating List",
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //
          //             Row(
          //               children: [
          //                 text(
          //                   "Title",
          //                 ),
          //                 Container(
          //                   width: 160,
          //                   child: TextField(
          //                     decoration: const InputDecoration(
          //                         enabledBorder: OutlineInputBorder(
          //                           borderSide: BorderSide(color: Colors.black),
          //                         ),
          //                         focusedBorder: OutlineInputBorder(
          //                             borderSide: BorderSide(color: Colors.black)),
          //                         isDense: true,
          //                         contentPadding: EdgeInsets.all(10.0),
          //                         hintStyle: TextStyle(fontSize: 13),
          //                         border: OutlineInputBorder(
          //                           borderSide: BorderSide(color: Colors.black),
          //                         )),
          //                      controller: empIDController,
          //                     onTap: () {
          //                       // _selectDate(context,"start");
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //
          //             Row(
          //               children: [
          //                 Text(
          //                   "Sub Title",
          //                   style: TextStyle(color: Colors.blue),
          //                 ),
          //                 Container(
          //                   width: 160,
          //                   child: TextField(
          //                     decoration: const InputDecoration(
          //                         enabledBorder: OutlineInputBorder(
          //                           borderSide: BorderSide(color: Colors.black),
          //                         ),
          //                         focusedBorder: OutlineInputBorder(
          //                             borderSide: BorderSide(color: Colors.black)),
          //                         isDense: true,
          //                         contentPadding: EdgeInsets.all(10.0),
          //                         hintStyle: TextStyle(fontSize: 13),
          //                         border: OutlineInputBorder(
          //                           borderSide: BorderSide(color: Colors.black),
          //                         )),
          //                     // controller: startdc,
          //                     onTap: () {
          //                       // _selectDate(context,"start");
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //
          //              const Text(
          //               "Capture the Picture",
          //               style: TextStyle(color: Colors.blue),
          //             ),
          //
          //             Container(
          //                 child: Column(
          //                     children:[
          //
          //                       Container(
          //                           height:200,
          //                           width:200,
          //                           child: controller == null?
          //                           Center(child:Text("Loading Camera...")):
          //                           !controller!.value.isInitialized?
          //                           Center(
          //                             child: CircularProgressIndicator(),
          //                           ):
          //                           CameraPreview(controller!)
          //                       ),
          //
          //                       ElevatedButton.icon( //image capture button
          //                         onPressed: () async{
          //                           try {
          //                             if(controller != null){ //check if contrller is not null
          //                               if(controller!.value.isInitialized){ //check if controller is initialized
          //                                 image = await controller!.takePicture(); //capture image
          //                                 setState(() {
          //                                   //update UI
          //                                 });
          //                               }
          //                             }
          //                           } catch (e) {
          //                             print(e); //show error
          //                           }
          //                         },
          //                         icon: Icon(Icons.camera),
          //                         label: Text("Capture"),
          //                       ),
          //
          //                       Container( //show captured image
          //                         padding: EdgeInsets.all(30),
          //                         child: image == null?
          //                         Text("No image captured"):
          //                         Image.file(File(image!.path), height: 200,),
          //                         //display captured image
          //                       )
          //
          //                     ]
          //                 )
          //             ),
          //
          //             Center(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   TextButton(
          //                       onPressed: () async {
          //                         Navigator.pop(context);
          //                       },
          //                       child: const Text(
          //                         "Yes",
          //                         style: TextStyle(color: Colors.black87),
          //                       )),
          //                   TextButton(
          //                       onPressed: () {
          //                         if(empIDController.text!=null){
          //
          //                         }
          //                         else{
          //
          //                         }
          //
          //                       },
          //                       child: const Text(
          //                         "No",
          //                         style: TextStyle(color: Colors.black87),
          //                       ))
          //                 ],
          //               ),
          //             ),
          //
          //           ],
          //         ),
          //
          // ),

       // )
    );
  }
}
