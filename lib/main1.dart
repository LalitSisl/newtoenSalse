//
//
// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
//   class MyApp extends StatelessWidget {
//
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
//
//
//  }
//
// class MyHomePage extends StatefulWidget {
//
//   const MyHomePage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image;
//
//   Widget text(String value) {
//     return RichText(
//       text: TextSpan(
//           text: value,
//           style: const TextStyle(
//             color: Colors.black,
//           ),
//           children: const [
//             TextSpan(
//                 text: ' *',
//                 style: TextStyle(
//                   color: Colors.red,
//                 ))
//           ]),
//     );
//   }
//
//  Future  _incrementCounter() {
//    return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Center(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0)),
//               elevation: 10,
//               child: SizedBox(
//                   height: 120,
//                   width: 300,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Creating List",
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                         SizedBox(height: 10,),
//                          text(
//                           "Title",
//
//                         ),
//                         SizedBox(height: 10,),
//                         Container(
//                           width: 160,
//                           child: TextField(
//                             decoration: const InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.black)),
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.all(10.0),
//                                 hintStyle: TextStyle(fontSize: 13),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 )),
//                            // controller: startdc,
//                             onTap: (){
//                              // _selectDate(context,"start");
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         const Text(
//                           "Sub Title",
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                         SizedBox(height: 10,),
//                         Container(
//                           width: 160,
//                           child: TextField(
//                             decoration: const InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.black)),
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.all(10.0),
//                                 hintStyle: TextStyle(fontSize: 13),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 )),
//                             // controller: startdc,
//                             onTap: (){
//                               // _selectDate(context,"start");
//                             },
//                           ),
//                         ),
//                         Center(
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                   onPressed: () async {
//
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text(
//                                     "Yes",
//                                     style: TextStyle(
//                                         color: Colors.black87),
//                                   )),
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text(
//                                     "No",
//                                     style: TextStyle(
//                                         color: Colors.black87),
//                                   ))
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         const Text(
//                           "Capture the Picture",
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                         Container(
//                             child: Column(
//                                 children:[
//                                   Container(
//                                       height:300,
//                                       width:400,
//                                       child: controller == null?
//                                       Center(child:Text("Loading Camera...")):
//                                       !controller!.value.isInitialized?
//                                       Center(
//                                         child: CircularProgressIndicator(),
//                                       ):
//                                       CameraPreview(controller!)
//                                   ),
//
//                                   ElevatedButton.icon( //image capture button
//                                     onPressed: () async{
//                                       try {
//                                         if(controller != null){ //check if contrller is not null
//                                           if(controller!.value.isInitialized){ //check if controller is initialized
//                                             image = await controller!.takePicture(); //capture image
//                                             setState(() {
//                                               //update UI
//                                             });
//                                           }
//                                         }
//                                       } catch (e) {
//                                         print(e); //show error
//                                       }
//                                     },
//                                     icon: Icon(Icons.camera),
//                                     label: Text("Capture"),
//                                   ),
//
//                                   Container( //show captured image
//                                     padding: EdgeInsets.all(30),
//                                     child: image == null?
//                                     Text("No image captured"):
//                                     Image.file(File(image!.path), height: 300,),
//                                     //display captured image
//                                   )
//                                 ]
//                             )
//                         ),
//
//                       ],
//                     ),
//                   )),
//             ),
//           );
//         });
//   }
//
//   loadCamera() async {
//     cameras = await availableCameras();
//     if(cameras != null){
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera
//
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     }else{
//       print("NO any camera found");
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     loadCamera();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Create',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//
// }
