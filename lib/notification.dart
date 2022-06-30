import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var notyLength=notificationList!=null && notificationList.isNotEmpty ?notificationList.length:0;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: notificationList!=null?
          ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
        var id=    notificationList[index]["Id"].toString();
        var subject=    notificationList[index]["Subject"].toString();
        var textNoty=    notificationList[index]["Text"].toString();
        var employee=    notificationList[index]["EMPLOYEE"].toString();
            return Card(
              color: const Color.fromARGB(255, 191, 200, 209),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('Id:  '+id),
                        const SizedBox(
                          height: 10,
                        ),
                        text('Subject: '+subject),
                        const SizedBox(
                          height: 10,
                        ),
                        text('Description: '+textNoty),
                        const SizedBox(
                          height: 10,
                        ),
                        text('Employee: '+employee),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),

                  ],
                ),
              ),
            );
          }):Container(child: Text("No Notifications are there"),),
    ));
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(),
    );
  }

  String staffCode="";

  var distributorList;

  var notificationList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }

  getStaffCode() async{

    setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
      getNotifications();
      //  staffController.text=staffCode;
    });


  }

  getNotifications() async {

    var res= await http.post(Uri.parse(API.notification),headers: {
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
      var reportIs= report.replaceAll("\n","\\n");

      reportIs=jsonDecode(reportIs);
      print("data is $reportIs");
      setState(() {
        notificationList=reportIs['Instruction'];
      });

      print("notificationList is $notificationList");

    }

    else{

    }






  }

}
