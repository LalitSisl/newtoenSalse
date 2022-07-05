import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/event_detail_model.dart';
import '../Network/api.dart';
import '../utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {

  bool isLoading = true;
  List<EventDetailModel> eventDetailList = <EventDetailModel>[];

  _getEventDetail() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Event_Summary),headers: {
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
          eventDetailList.add(EventDetailModel.fromJson(v));
        });
        // eventType = eventTypeList[0];
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
    _getEventDetail();
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
          itemCount: eventDetailList.isNotEmpty ? eventDetailList.length : 0,
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
                            child: text('Name:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(eventDetailList[index].name != null ? '${eventDetailList[index].name}' : '--')),
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
                            child: text('Phone:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(eventDetailList[index].phone != null ? '${eventDetailList[index].phone}' : '--')
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
                            child: text('DOB:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              eventDetailList[index].dOB != null ?
                              '${eventDetailList[index].dOB}' : '--'),
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
                            child: text('Address:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              eventDetailList[index].address != null ?
                              '${eventDetailList[index].address}' : '--'),
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
                              eventDetailList[index].date != null ?
                              '${eventDetailList[index].date}' : '--'),
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
