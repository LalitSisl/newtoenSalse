import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/dashboard_order_list_model.dart';
import '../Network/api.dart';
import 'package:http/http.dart' as http;

import '../utils/secure_storage.dart';
class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String staffCode="";
  bool isLoading = false;
  List<DashboardOrderListModel> orderList = <DashboardOrderListModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
  }
  getStaffCode() async{

    setState(() async {
      staffCode=await UserSecureStorage().getStaffId();
      getOrders();
      //  staffController.text=staffCode;
    });


  }

  getOrders() async {
setState((){
  isLoading = true;
});
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
        list = object['ItemList'];
        print('length> ${list.length}');
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
  var list;
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
          'Product',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: isLoading ?
          const Center(

              child: SizedBox(

                  child: CircularProgressIndicator())):
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => RetailerView()));
                },
                child: Card(
                  child: ListTile(
                    title: Text('${list[snapshot]['ITEM_ITEM_NAME']}'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
