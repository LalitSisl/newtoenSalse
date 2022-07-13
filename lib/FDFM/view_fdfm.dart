import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/FDFM/FDFMBean.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import '../Network/api.dart';

class ViewFDFM extends StatefulWidget {
  const ViewFDFM({Key? key}) : super(key: key);

  @override
  State<ViewFDFM> createState() => _ViewFDFMState();
}


class _ViewFDFMState extends State<ViewFDFM> {
 bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }
var staffCode;
  Future getStaffCode() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() async {
    staffCode= await UserSecureStorage().getStaffId();
    // });
    print("staff id -----> $staffCode");
    downloadFDFM();
  }
  var listcount;
  downloadFDFM() async {
    setState((){
      isLoading = true;
    });
    var res= await http.post(Uri.parse(API.downloadFDFM),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_sUserId":staffCode,
          "_VisitorCode":"101",
          "_TenantCode": "01",
          "_Location":"110001"
        }
    );


    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode == 200){
      //print(res.body);
      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();

      //print("xml2Json is ${jsonString}");

      var data = jsonDecode(jsonString);

      var report=data['DataSet'];

      var diff=report['diffgr:diffgram'];

      var newdata =diff['NewDataSet'];

      // var reportIs=jsonDecode(newdata);
      //print("xml2Json is ${reportIs}");
      setState(() {
        listcount = newdata['Table1'];
        print('arrey > ${listcount.length}');
      });

      setState((){
        isLoading = false;
      });
    }

    else{
      setState((){
        isLoading = false;
      });
    }
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
          'View FDFM',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body:
          isLoading ?
          const Center(
            child: SizedBox(
                height: 40,
                width: 40,
                child:  CircularProgressIndicator()),
          ):
     ListView.builder(
    itemCount: listcount.length,
      itemBuilder: (BuildContext context, index) {
        return Card(
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text("Date:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text('${listcount[index]['PLAN_DATE']}',textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text("Distributor:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text('${listcount[index]['PARTY_x0020_NAME']}',textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text("Beat:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text('${listcount[index]['Beat']}',textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text("Retailer:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text('${listcount[index]['RETAILER_x0020_NAME']}',textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text("MTD Sales:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text('${listcount[index]['MTDSALE']}',textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    )
    );
  }

}
