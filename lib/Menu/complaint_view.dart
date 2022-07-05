import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/Models/complaint_view_model.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';
import '../utils/secure_storage.dart';
class ComplaintView extends StatefulWidget {
  const ComplaintView({Key? key}) : super(key: key);

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {

  bool isLoading = true;
  List<ComplaintViewModel> complaintList = <ComplaintViewModel>[];

  _getComplaint() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Complaint_Detail_View),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffID':"$staffId",
          '_VisitCode':'101',
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
        object['EventSummary'].forEach((v) {
          complaintList.add(ComplaintViewModel.fromJson(v));
        });
        // product = productList[0];
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
    _getComplaint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Complaint View',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),

      ),
      body: isLoading?
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )
          : ListView.builder(
          itemCount: complaintList.isNotEmpty ? complaintList.length : 0,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 166, 207, 240),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Party Code:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(complaintList[index].partyCode != null ? '${complaintList[index].partyCode}' : '--')),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Party:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(complaintList[index].party != null ? '${complaintList[index].party}' : '--')
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Product:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              complaintList[index].productCategory != null ?
                              '${complaintList[index].productCategory}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Complaint Type:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              complaintList[index].complainntType != null ?
                              '${complaintList[index].complainntType}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Remarks:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              complaintList[index].remarks != null ?
                              '${complaintList[index].remarks}' : '--'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            // return Container();
          }),
    );
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(),
    );
  }
}
