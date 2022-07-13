import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/daily_calls_model.dart';
import '../Network/api.dart';
import 'package:http/http.dart' as http;
class ViewDailyCalls extends StatefulWidget {
  const ViewDailyCalls({Key? key}) : super(key: key);

  @override
  State<ViewDailyCalls> createState() => _ViewDailyCallsState();
}

class _ViewDailyCallsState extends State<ViewDailyCalls> {
  bool isLoading = false;
  DailyCallsModel dailyCallsModel = DailyCallsModel();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }
var staffCode;
  getStaffCode() async{

    setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
      _getCustomers();
      //  staffController.text=staffCode;
    });


  }

  _getCustomers() async {
    setState((){
      isLoading = true;
    });
    var res= await http.post(Uri.parse(API.Ws_Get_Call_History),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "UserId":staffCode,

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
      var subAreaCodeObject=data['string'];
      subAreaCodeObject = subAreaCodeObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(subAreaCodeObject.toString());
      setState(() {
        list = object['call_History'];
        object['call_History'].forEach((v) {
          //orderList.add(DashboardOrderListModel.fromJson(v));
        });
        isLoading = false;
      });
    }
    else{
      setState((){
        isLoading = false;
      });
    }
  }

var list;


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
          'Daily Calls View',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),

      ),
      body: isLoading?
      const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
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
                              child: text('Date:')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(list[index]['Date'] ?? '--')),
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
                              child: text('Sub Area:')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: text(list[index]['Area Desc'] ?? '--')
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
                              child: text('Category:')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(
                                list[index]['Category Name'] ?? '--'),
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
                              child: text('Calls Made:')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(
                                list[index]['Calls_Made'].toString()),
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
                              child: text('Eff. Calls:')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(
                                list[index]['Effective_Calls'].toString()),
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
                              child: text('Quantity:')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(
                                list[index]['Qty'].toString()),
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
                              child: text('Amount:')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(
                                list[index]['Amount'].toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            // return Container();
          }),
    );
  }

  Widget text(String value) {
    return RichText(
      text: TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
          ),
          // children: const [
          //   TextSpan(
          //       text: ' *',
          //       style: TextStyle(
          //         color: Colors.red,
          //       ))
          // ]
      ),
    );
  }
}
