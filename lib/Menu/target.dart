import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';
class Target extends StatefulWidget {
  const Target({Key? key}) : super(key: key);

  @override
  State<Target> createState() => _TargetState();
}

class _TargetState extends State<Target> {
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
          'Target',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
    );
  }

  String staffCode="";

  var distributorList;

  var instructionList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }

  getStaffCode() async{

    setState(() async {
      staffCode=await UserSecureStorage().getStaffId();
      _getCustomers();
      //  staffController.text=staffCode;
    });


  }

  _getCustomers() async {

    var res= await http.post(Uri.parse(API.target),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_StaffID":staffCode,
          "_VisitCode":"01",
          "_TenantCode": "101",
          "SearchText":"@0deault",
          "_Location":"1100001"
        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    print("res is $bodyIs");

    if(statusCode==200){

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();

      print("xml2Json is ${jsonString}");

      var data = jsonDecode(jsonString);
      var report=data['string'];
      var reportIs=jsonDecode(report);
      print("data is $reportIs");
      setState(() {
        instructionList=reportIs['Instruction'];
      });

      print("instructionList is $instructionList");

    }

    else{

    }






  }
}
