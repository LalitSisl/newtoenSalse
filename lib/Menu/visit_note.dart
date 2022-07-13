import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/visit_note_model.dart';
import '../Network/api.dart';
import '../utils/secure_storage.dart';
import 'package:http/http.dart' as http;
class VisitNote extends StatefulWidget {
  const VisitNote({Key? key}) : super(key: key);

  @override
  State<VisitNote> createState() => _VisitNoteState();
}

class _VisitNoteState extends State<VisitNote> {

  bool isLoading = true;
  List<VisitNoteModel> visitNoteList = <VisitNoteModel>[];

  _getVisitNote() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Secondry_Sale_Dynamic_Report),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffID':"$staffId",
          '_VisitCode':'101',
          '_TenantCode': '01',
          '_Location': '110001',
          'ReportType': '09'
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
        object['Report'].forEach((v) {
          visitNoteList.add(VisitNoteModel.fromJson(v));
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
    _getVisitNote();
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
          'Visit Note View',
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
          itemCount: visitNoteList.isNotEmpty ? visitNoteList.length : 0,
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
                            child: text('Visit Type:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(visitNoteList[index].visitType != null ? '${visitNoteList[index].visitType}' : '--')),
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
                            child: text('Remark:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(visitNoteList[index].remarks != null ? '${visitNoteList[index].remarks}' : '--')
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
                            child: text('Date:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              visitNoteList[index].date != null ?
                              '${visitNoteList[index].date}' : '--'),
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
