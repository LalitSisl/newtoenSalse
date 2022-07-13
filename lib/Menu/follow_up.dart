import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';

class FollowUp extends StatefulWidget {
  const FollowUp({Key? key}) : super(key: key);

  @override
  State<FollowUp> createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUp> {

  List followUpList = [];
  bool isLoading = true;
  var staffCode;

  getStaffCode() async{

      staffCode= await UserSecureStorage().getStaffId();
      _getFollowUp();
      //  staffController.text=staffCode;



  }

  _getFollowUp() async {

    var res= await http.post(Uri.parse(API.Ws_FollowUp_Detail_View_V2),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: jsonEncode({
          '_StaffID ': '$staffCode',
          '_VisitorCode':'101',
          '_TenantCode': '01',
          '_Location': '110001',
          '_Searchtype': '@0deault'
        })
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
      var followUpObject=data['string'];
      setState(() {
        followUpList = followUpObject['EventSummary'];
        isLoading = false;
      });

    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

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
            'Follow-Up Details',
            style:
                TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading?
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator()
                ),
              )
              : ListView.builder(
              itemCount: followUpList.isNotEmpty ? followUpList.length:0,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 191, 200, 209),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: text('Party Name:'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(followUpList[index]["Party"]!=null?'${followUpList[index]["Party"]}':'--'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: text('Staff Id:'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(followUpList[index]["StaffId"]!=null?'${followUpList[index]["StaffId"]}':'--'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: text('Remark:'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(followUpList[index]["Remarks"]!=null?'${followUpList[index]["Remarks"]}':'--'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: text('Date:'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(followUpList[index]["Date"]!=null?'${followUpList[index]["Date"]}':'--'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(),
    );
  }
}
