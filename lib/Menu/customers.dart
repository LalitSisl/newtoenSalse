import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/Menu/DistributedBean.dart';
import 'package:salesapp/Menu/retailer_view.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';
class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {

  String staffCode="";

  var distributorList;

  var reportList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
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
          'Customers',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: reportList!=null?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListView.builder(
            itemCount:  reportList.length,
            itemBuilder: (context, index) {
              var distributorName=reportList[index]["DISTRIBUTOR_NAME"].toString();
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RetailerView()));
                },
                child:  Card(
                  child: ListTile(
                    title: Text(distributorName),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
              );
            }),
      ):Container(child:Text("No Customers are found")),
    );
  }

  getStaffCode() async{

    setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
      _getCustomers();
    //  staffController.text=staffCode;
    });


  }

  _getCustomers() async {

    var res= await http.post(Uri.parse(API.customers),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_StaffID":staffCode,
          "_VisitCode":"01",
          "_TenantCode": "101",
          "ReportType":"16",
          "_Searchtype":"@0deault",
          "_Location":"1100001"
        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    print("res is $bodyIs");

    if(statusCode==200){




      // print("res is ${res.body}");
      //
      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();

      print("xml2Json is ${jsonString}");

      var data = jsonDecode(jsonString);
      var report=data['string'];
      var reportIs=jsonDecode(report);
      print("data is $reportIs");
      setState(() {
        reportList=reportIs['Report'];
      });

      print("reportList is $reportList");

    }
    else{
    }
  }
}
