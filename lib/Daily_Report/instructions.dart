import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/instruction_model.dart';
import '../Network/api.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {

  bool isLoading = true;
  List<InstructionModel> instructionList = <InstructionModel>[];
  InstructionModel instruction = InstructionModel();

  _getInstructionList() async {
    var res= await http.post(Uri.parse(API.Ws_Special_Instruction),headers: {
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
        object['Instruction'].forEach((v) {
          instructionList.add(InstructionModel.fromJson(v));
        });
        instruction = instructionList[0];
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
    _getInstructionList();
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
          'Instructions',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ?
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ):
          ListView.builder(
              itemCount: instructionList.isNotEmpty?instructionList.length:0,
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
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://img.icons8.com/office/2x/circled-up.png"),
                              //whatever image you can put here
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        text("${instructionList[index].mEMOTEXT}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // text('Jagveer'),
                            text("${instructionList[index].mEMODATE}"),
                          ],
                        ),

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
      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
    );
  }
}
