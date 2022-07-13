
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../Models/sys_type.dart';
import '../Network/api.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  var type;
  bool isLoading = true;
  SysType expenses = SysType();
  List<SysType> expensesList = [];

  _getExpensesType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType':'BANKS',
          '_UserName':"userId",
          '_VisitorId':'101',
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
      var zoneObject=data['string'];
      zoneObject = zoneObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(zoneObject.toString());
      setState(() {
        object['SysType'].forEach((v) {
          expensesList.add(SysType.fromJson(v));
        });
        expenses = expensesList[0];
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
    _getExpensesType();
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
          'Expense',
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
            text('Expense Type'),
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
                value: expenses,
                hint: const Text(
                  'Select Item',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: expensesList.map<DropdownMenuItem<SysType>>((SysType value) {
                  return DropdownMenuItem<SysType>(
                    child: Text(value.name!),
                    value: value,
                  );
                }).toList(),
                onChanged: (SysType? value) {
                  setState(() {
                    expenses = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),
            const SizedBox(height: 7,),
            text('From Date'),
            const SizedBox(
              height: 5,
            ),
            const TextField(
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
            text('To Date'),
            const SizedBox(
              height: 5,
            ),
            const TextField(
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
            text('Expense Amount'),
            const SizedBox(
              height: 5,
            ),
            const TextField(
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
            text('Remarks'),
            const SizedBox(
              height: 5,
            ),
            const TextField(
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
              },
              child: Container(
                child: const Center(
                  child: Text(
                    'Add Expenses',
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

