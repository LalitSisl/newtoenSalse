import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';

class Scheme extends StatefulWidget {
  const Scheme({Key? key}) : super(key: key);

  @override
  State<Scheme> createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> {

  _getSchemes() async {
    var res= await http.post(Uri.parse(API.Ws_FDFM_SchemesDetails_V2),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_VisitorCode":"101",
          "_TenantCode": "01",
          "_Location":"110001",
          "_Searchtype": "@0deault"
        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){

      print("res is ${res.body}");

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();

      print("xml2Json is ${jsonString}");

      var data = jsonDecode(jsonString);
      print("data -----> $data");
      // var staffId=data['string'];
    }

    else{

    }






  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSchemes();
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
          'Scheme Details',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
    );
  }
}
