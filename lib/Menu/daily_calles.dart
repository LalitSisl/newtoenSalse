import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/Menu/view_daily_calls.dart';
import 'package:salesapp/Models/category.dart';
import 'package:salesapp/Models/sub_area_code.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';

class DailyCalls extends StatefulWidget {
  const DailyCalls({Key? key}) : super(key: key);

  @override
  State<DailyCalls> createState() => _DailyCallsState();
}

class _DailyCallsState extends State<DailyCalls> {
  final _formKey = GlobalKey<FormState>();
  SubAreaCode subAreaCode = SubAreaCode();
  List<SubAreaCode> subAreaCodeList = [];
  Category category = Category();
  List<Category> categoryList = [];
  bool isLoading = true;
  bool isButtonLoading = false;
  var salesExecutiveController = TextEditingController(text: "admin");
  var dateController = TextEditingController();
  var callsMadeController = TextEditingController();
  var effectiveCallsController = TextEditingController();
  var quantityController = TextEditingController();
  var amountController = TextEditingController();

  _getSubArea() async {
    var res= await http.post(Uri.parse(API.Ws_Get_SubArea),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          'AreaCode':''
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
      var subAreaCodeObject=data['string'];
      subAreaCodeObject = subAreaCodeObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(subAreaCodeObject.toString());
      setState(() {
        object['SchemeList'].forEach((v) {
          subAreaCodeList.add(SubAreaCode.fromJson(v));
        });
        subAreaCode = subAreaCodeList[0];
        // isLoading = false;
      });
    }
    else{
      // setState(() {
      //   isLoading = false;
      // });
    }
    _getCategory();
  }

  _getCategory() async {
    var res= await http.post(Uri.parse(API.Ws_Get_ItemCategory),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
      // body: {
      //   'AreaCode':''
      // }
    );

    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){

      print("res is ${res.body}");

      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();
      var data = jsonDecode(jsonString);
      var categoryObject=data['string'];
      categoryObject = categoryObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(categoryObject.toString());
      setState(() {
        object['SchemeList'].forEach((v) {
          categoryList.add(Category.fromJson(v));
        });
        category = categoryList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _postSubmit() async {
    var userId = await UserSecureStorage().getStaffId();
    var body = {
      "ITEM":[
        {
          "Date": dateController.text.toString(),
          "SaleExecutive" : salesExecutiveController.text.toString(),
          "Area": "",
          "SubArea": subAreaCode.subAreaCode.toString(),
          "Calls_Made": callsMadeController.text.toString(),
          "Executive_Calls": effectiveCallsController.text.toString(),
          "Category": category.categoryId.toString(),
          "Qty": quantityController.text.toString(),
          "Amount": amountController.text.toString()
        }
      ]
    };
    var bodyStr = {
      "Date": dateController.text.toString(),
      "SaleExecutive" : salesExecutiveController.text.toString(),
      "Area": "",
      "SubArea": subAreaCode.subAreaCode.toString(),
      "Calls_Made": callsMadeController.text.toString(),
      "Executive_Calls": effectiveCallsController.text.toString(),
      "Category": category.categoryId.toString(),
      "Qty": quantityController.text.toString(),
      "Amount": amountController.text.toString()
    };
    await UserSecureStorage().setDailyCalls(bodyStr.toString());
    Fluttertoast.showToast(msg: "Daily Call submitted");
    var res= await http.post(Uri.parse(API.Ws_Save_Sales_Executive_Calls_Details),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          'user_code':'$userId',
          'json_string': body.toString()
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
      var responseObject=data['string'];
      // categoryObject = categoryObject.toString().replaceAll("\\r\\\\n", "\n");
      // var object = json.decode(categoryObject.toString());
      print("responseObject ----> $responseObject");
      setState(() {
        // object['SchemeList'].forEach((v) {
        //   categoryList.add(Category.fromJson(v));
        // });
        // category = categoryList[0];
        isButtonLoading = false;
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
    _getSubArea();
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
          'Daily Calls',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: isLoading? SizedBox(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
            :Form(
          key: _formKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('Sales Executive'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: salesExecutiveController,
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
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
                    ),
                  ),
                  enabled: false,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Date'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
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
                      ),
                    hintText: "yyyy-mm-dd",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Sub Area'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: DropdownButtonFormField<SubAreaCode>(
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
                    value: subAreaCode,
                    hint: const Text(
                      'Select Sub area',
                      style: TextStyle(fontSize: 13),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,

                    iconSize: 20,
                    style: TextStyle(color: Colors.black),

                    items: subAreaCodeList.map<DropdownMenuItem<SubAreaCode>>((SubAreaCode value) {
                      return DropdownMenuItem<SubAreaCode>(
                        child: Text(value.subAreaDesc!),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (SubAreaCode? value) {
                      setState(() {
                        subAreaCode = value!;
                      });
                    },
                    //value: dropdownProject,
                    validator: (value) => value == null ? 'field required' : null,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Category'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: DropdownButtonFormField<Category>(
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
                    value: category,
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(fontSize: 13),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,

                    iconSize: 20,
                    style: TextStyle(color: Colors.black),

                    items: categoryList.map<DropdownMenuItem<Category>>((Category value) {
                      return DropdownMenuItem<Category>(
                        child: Text(value.categoryName!),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (Category? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                    //value: dropdownProject,
                    validator: (value) => value == null ? 'field required' : null,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Calls Made'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: callsMadeController,
                  decoration: const InputDecoration(
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
                      )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Effective Calls'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: effectiveCallsController,
                  decoration: const InputDecoration(
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
                      )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Quantity'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: const InputDecoration(
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
                      )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Amount'),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
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
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                isButtonLoading?
                Container(
                  padding: const EdgeInsets.all(10.0),
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
                )
                :GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Dashboard()));
                    setState(() {
                      isButtonLoading = true;
                    });
                    _postSubmit();
                  },
                  child: Container(
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
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewDailyCalls()));
                    // setState(() {
                    //   isButtonLoading = true;
                    // });
                    // _postSubmit();
                  },
                  child: Container(
                    child: const Center(
                      child: Text(
                        'View Daily Calls',
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
              ]),
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
