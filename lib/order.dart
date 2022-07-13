import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/create_order.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import 'Models/dashboard_order_list_model.dart';
import 'Network/api.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String staffCode="";
  bool isLoading = true;
  List<DashboardOrderListModel> orderList = <DashboardOrderListModel>[];

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
      child: isLoading?
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      : ListView.builder(
          itemCount: orderList.isNotEmpty ? orderList.length : 0,
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
                        text('Item Name:'),
                        const SizedBox(
                          width: 50,
                        ),
                        text('${orderList[index].iTEMITEMNAME}'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Item Code:'),
                        const SizedBox(
                          width: 55,
                        ),
                        text('${orderList[index].iTEMITEMCODE}'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        text('Remarks:'),
                        const SizedBox(
                          width: 64,
                        ),
                        Expanded(
                          child: text(
                              '${orderList[index].itemDescRc}'),
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
                          child: text('${orderList[index].sTRMRP}'),
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
                          child: text('${orderList[index].iTEMTRFRATE}'),
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
                          width: 70,
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

      print("res is ${res.body}");

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var subAreaCodeObject=data['string'];
      subAreaCodeObject = subAreaCodeObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(subAreaCodeObject.toString());
      setState(() {
        object['ItemList'].forEach((v) {
          orderList.add(DashboardOrderListModel.fromJson(v));
        });
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }

  }


}
