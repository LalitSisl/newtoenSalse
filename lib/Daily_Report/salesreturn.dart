import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '../Models/stock_capture_category_model.dart';
import '../Models/sys_type.dart';
import '../Network/api.dart';
import '../utils/secure_storage.dart';

class SalesReturn extends StatefulWidget {
  const SalesReturn({Key? key}) : super(key: key);

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  bool isLoading = true;
  bool isButtonLoading = false;
  List<SysType> reasonList = <SysType>[];
  SysType reasonType = SysType();
  List<StockCaptureCategoryModel> productCategoryList = <StockCaptureCategoryModel>[];
  StockCaptureCategoryModel productCategory = StockCaptureCategoryModel();
  var amountController = TextEditingController();
  var batchController = TextEditingController();
  var quantityController = TextEditingController();

  _getReasonType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "SALES_RETURN_REASON",
          '_UserName':"01",
          '_VisitorId':'01',
          '_TenantCode': '101',
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
        object['SysType'].forEach((v) {
          reasonList.add(SysType.fromJson(v));
        });
        reasonType = reasonList[0];
        // isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
    _getProductCategory();
  }

  _getProductCategory() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_FDM_ItemMaster),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId':"$staffId",
          '_VisitorCode':'01',
          '_TenantCode': '101',
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
        object['ItemList'].forEach((v) {
          productCategoryList.add(StockCaptureCategoryModel.fromJson(v));
        });
        productCategory = productCategoryList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _saveSalesReturn() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Sales_Return),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId': "$staffId",
          '_PartyCode':"",
          '_Reason':"${reasonType.value}",
          '_Amount':amountController.text,
          '_BatchNo':batchController.text,
          '_ItemCode':"${productCategory.iTEMITEMCODE}",
          '_Quantity':quantityController.text,
          '_VisitCode':'101',
          '_TenantCode':'01',
          '_Location':'110001'
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
        // object['SysType'].forEach((v) {
        //   bankTypeList.add(SysType.fromJson(v));
        // });
        // bankType = bankTypeList[0];
        Navigator.of(context).pop();
        isButtonLoading = false;
        Fluttertoast.showToast(msg: "Sales Return Saved");
      });
    }
    else{
      setState(() {
        isButtonLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getReasonType();
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
          'Sales Return',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            text('Reason'),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: DropdownButtonFormField<SysType>(
                decoration: const InputDecoration(
                  isDense: true, // Added this
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                value: reasonType,
                hint: const Text(
                  'Select Item',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: reasonList.map<DropdownMenuItem<SysType>>((SysType value) {
                  return DropdownMenuItem<SysType>(
                    child: Text(value.name!),
                    value: value,
                  );
                }).toList(),
                onChanged: (SysType? value) {
                  setState(() {
                    reasonType = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),

            const SizedBox(height: 7,),
            text('Amount'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                  hintStyle: TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 7,
            ),
            text('Batch No.'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: batchController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                  hintStyle: TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 7,
            ),
            text('Product Category'),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: DropdownButtonFormField<StockCaptureCategoryModel>(
                decoration: const InputDecoration(
                  isDense: true, // Added this
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                value: productCategory,
                hint: const Text(
                  'Select Item',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: productCategoryList.map<DropdownMenuItem<StockCaptureCategoryModel>>((StockCaptureCategoryModel value) {
                  return DropdownMenuItem<StockCaptureCategoryModel>(
                    child: Text(value.iTEMITEMNAME!),
                    value: value,
                  );
                }).toList(),
                onChanged: (StockCaptureCategoryModel? value) {
                  setState(() {
                    productCategory = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     text('Item'),
            //     text('Quantity'),
            //   ],
            // ),
            // const SizedBox(
            //   height: 7,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: const [
            //     Expanded(
            //       flex: 3,
            //       child:  TextField(
            //         decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(color: Colors.black)),
            //             isDense: true,
            //             contentPadding: EdgeInsets.all(10.0),
            //             hintStyle: TextStyle(fontSize: 13),
            //             border: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             )),
            //       ),
            //     ),
            //     Spacer(),
            //     Expanded(
            //       flex: 2,
            //       child:  TextField(
            //         decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(color: Colors.black)),
            //             isDense: true,
            //             contentPadding: EdgeInsets.all(10.0),
            //             hintStyle: TextStyle(fontSize: 13),
            //             border: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 3,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: const [
            //     Expanded(
            //       flex: 3,
            //       child:  TextField(
            //         decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(color: Colors.black)),
            //             isDense: true,
            //             contentPadding: EdgeInsets.all(10.0),
            //             hintStyle: TextStyle(fontSize: 13),
            //             border: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             )),
            //       ),
            //     ),
            //     Spacer(),
            //     Expanded(
            //       flex: 2,
            //       child:  TextField(
            //         decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(color: Colors.black)),
            //             isDense: true,
            //             contentPadding: EdgeInsets.all(10.0),
            //             hintStyle: TextStyle(fontSize: 13),
            //             border: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.black),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
            text('Quantity'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                  hintStyle: TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  )),
            ),

            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Dashboard()));
                setState(() {
                  isButtonLoading = true;
                });
                _saveSalesReturn();
              },
              child: isButtonLoading ?
              Container(
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.0,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 16, 36, 53),
                ),
                height: 40,
              ):
              Container(
                child: const Center(
                  child: Text(
                    'Save',
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 16, 36, 53),
                ),
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget text(String value) {
    return RichText(
      text: TextSpan(
        text: value,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
