import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/create_order.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import 'Network/api.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String staffCode="";

  var orderList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 3,
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
                      children: [
                        text('Customer Name:'),
                        const SizedBox(
                          width: 20,
                        ),
                        text('Lalit Sharma'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Item List:'),
                        const SizedBox(
                          width: 70,
                        ),
                        text('EMBOSSED'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Remarks:'),
                        const SizedBox(
                          width: 68,
                        ),
                        Expanded(
                          child: text(
                              'Dear Jagveer There is a new lead posted with the remarks.'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Item Price:'),
                        const SizedBox(
                          width: 58,
                        ),
                        FittedBox(
                          child: text('2000'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Item Quantity:'),
                        const SizedBox(
                          width: 37,
                        ),
                        FittedBox(
                          child: text('2'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Amount:'),
                        const SizedBox(
                          width: 73,
                        ),
                        FittedBox(
                          child: text('2000'),
                        ),
                      ],
                    )
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

  getStaffCode() async{

    setState(() async {
      staffCode=await UserSecureStorage().getStaffId();
      getOrders();
      //  staffController.text=staffCode;
    });


  }

  getOrders() async {

    var res= await http.post(Uri.parse(API.order_itemmaster),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "UserID":staffCode,

        }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    print("res is $bodyIs");

    if(statusCode==200){

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
     var jsonString1=jsonString.replaceAll("\\r\\\\n  ", "\\n");
      print("xml2Json1 is ${jsonString1}");

      var data = jsonDecode(jsonString1);
      var report=data['string'];
      var reportIs= report.replaceAll("\r\\n","\\n");

       reportIs=jsonDecode(reportIs);
      print("data is $reportIs");
      setState(() {
        orderList=reportIs['ItemList'];
      });

      print("notificationList is $orderList");

    }

    else{

    }






  }


}
