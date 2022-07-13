import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';
import '../utils/secure_storage.dart';

class SalesReturn extends StatefulWidget {
  const SalesReturn({Key? key}) : super(key: key);

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {

  bool isLoading = true;

  _getSalesReturn() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Sales_Return_View),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffID':"$staffId",
          '_PartyCode':"",
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
      var productObject=data['string'];
      productObject = productObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(productObject.toString());
      setState(() {
        // object['SysType'].forEach((v) {
        //   productList.add(SysType.fromJson(v));
        // });
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
    _getSalesReturn();
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
          'Sales Return View',
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
          itemCount: 3,
          itemBuilder: (context, index) {
            // return Card(
            //   color: const Color.fromARGB(255, 166, 207, 240),
            //   elevation: 5,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             text('Item Name:'),
            //             const SizedBox(
            //               width: 20,
            //             ),
            //             text('${orderList[index].iTEMITEMNAME}'),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           children: [
            //             text('Item Code:'),
            //             const SizedBox(
            //               width: 70,
            //             ),
            //             text('${orderList[index].iTEMITEMCODE}'),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           children: [
            //             text('Remarks:'),
            //             const SizedBox(
            //               width: 68,
            //             ),
            //             Expanded(
            //               child: text(
            //                   '${orderList[index].itemDescRc}'),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           children: [
            //             text('Item Price:'),
            //             const SizedBox(
            //               width: 58,
            //             ),
            //             FittedBox(
            //               child: text('${orderList[index].sTRMRP}'),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           children: [
            //             text('Item Quantity:'),
            //             const SizedBox(
            //               width: 37,
            //             ),
            //             FittedBox(
            //               child: text('${orderList[index].iTEMTRFRATE}'),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           children: [
            //             text('Amount:'),
            //             const SizedBox(
            //               width: 73,
            //             ),
            //             FittedBox(
            //               child: text('2000'),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // );
            return Container();
          }),
    );
  }
}
