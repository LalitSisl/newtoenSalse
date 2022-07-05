
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/Menu/event_detail.dart';
import 'package:salesapp/Models/event_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '../Network/api.dart';
import '../utils/secure_storage.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  bool isLoading = true;
  bool isButtonLoading = false;
  List<EventTypeModel> eventTypeList = <EventTypeModel>[];
  EventTypeModel eventType = EventTypeModel();
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var dobController = TextEditingController();

  _getEventType() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "DocType",
          '_UserName':"$staffId",
          '_VisitorId':'101',
          '_TenantCode': '01',
          '_Location': '110001'
        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){

      print("res is ${res.body}");

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var complaintObject=data['string'];
      complaintObject = complaintObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(complaintObject.toString());
      setState(() {
        object['SysType'].forEach((v) {
          eventTypeList.add(EventTypeModel.fromJson(v));
        });
        eventType = eventTypeList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _postAddEvent() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Events),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId':"$staffId",
          '_VisitCode':'101',
          '_TenantCode': '01',
          '_Location': '110001',
          '_Name':nameController.text,
          '_DOB':dobController.text,
          '_Phone':phoneController.text,
          '_Address':addressController.text
        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){

      print("res is ${res.body}");

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var complaintObject=data['string'];
      complaintObject = complaintObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(complaintObject.toString());
      setState(() {
        // object['SysType'].forEach((v) {
        //   eventTypeList.add(EventTypeModel.fromJson(v));
        // });
        // eventType = eventTypeList[0];
        isButtonLoading = false;
      });
    }
    else{
      setState(() {
        isButtonLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 20, 20, 20),
            size: 18,
          ),
        ),
        title: const Text(
          'Event',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              text('Event Type'),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: DropdownButtonFormField<EventTypeModel>(
                  decoration: const InputDecoration(
                    isDense: true, // Added this
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  value: eventType,
                  hint: const Text(
                    'Select Item',
                    style: TextStyle(fontSize: 13),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,

                  iconSize: 20,
                  style: TextStyle(color: Colors.black),

                  items: eventTypeList.map<DropdownMenuItem<EventTypeModel>>((EventTypeModel value) {
                    return DropdownMenuItem<EventTypeModel>(
                      child: Text(value.name!),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (EventTypeModel? value) {
                    setState(() {
                      eventType = value!;
                    });
                  },
                  //value: dropdownProject,
                  validator: (value) => value == null ? 'field required' : null,
                ),
              ),
              const SizedBox(height: 7,),
              text('Name'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
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
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Field is Mandatory';
                  }
                },
              ),
              const SizedBox(
                height: 7,
              ),
              text('Phone Number'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
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
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Field is Mandatory';
                  }
                },
              ),
              const SizedBox(
                height: 7,
              ),
              text('Address'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
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
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Field is Mandatory';
                  }
                },
              ),
              const SizedBox(
                height: 7,
              ),
              text('Date of Birth'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    hintText: "dd-mm-yyyy",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Field is Mandatory';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isButtonLoading ?
              Container(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 16, 36, 53),
                ),
                height: 40,
              ) :
              GestureDetector(
                onTap: () {
                  setState(() {
                    isButtonLoading = true;
                  });
                  _postAddEvent();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Dashboard()));
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'Add Event',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 16, 36, 53),
                  ),
                  height: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EventDetailScreen()));
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'View Event',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 16, 36, 53),
                  ),
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget text(String value) {
    return RichText(
      text: TextSpan(
        text: value,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

