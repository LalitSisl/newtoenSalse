
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';
import '../Models/sys_type.dart';
import '../Network/api.dart';

class Collections extends StatefulWidget {
  const Collections({Key? key}) : super(key: key);

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {

  bool isLoading = true;
  bool isButtonLoading = false;
  List<SysType> transactionTypeList = <SysType>[];
  SysType transactionType = SysType();
  List<SysType> bankTypeList = <SysType>[];
  SysType bankType = SysType();
  var amountController = TextEditingController();
  var chequeNoController = TextEditingController();
  var dateController = TextEditingController();
  var billNoController = TextEditingController();
  var remarksController = TextEditingController();
  var buffer;

  _getTransactionType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "PAY_TYPE",
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
          transactionTypeList.add(SysType.fromJson(v));
        });
        transactionType = transactionTypeList[0];
        // isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
    _getBankType();
  }

  _getBankType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "BANKS",
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
          bankTypeList.add(SysType.fromJson(v));
        });
        bankType = bankTypeList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _saveCollection() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Collection_Master),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId': "$staffId",
          '_PartyCode':"",
          '_TransactionType':'${transactionType.value}',
          '_Amount': amountController.text,
          '_BankName': '${bankType.value}',
          '_BillNo': billNoController.text,
          '_ChequeNo': chequeNoController.text,
          '_Remark': remarksController.text,
          '_Image': 'selectedImagePath',
          '_buffer': '$buffer',
          '_Extension': '.PNG',
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
        Fluttertoast.showToast(msg: "Collection Saved");
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
    _getTransactionType();
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
          'Collections',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            text('Transaction Type'),
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
                value: transactionType,
                hint: const Text(
                  'Select Type',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: transactionTypeList.map<DropdownMenuItem<SysType>>((SysType value) {
                  return DropdownMenuItem<SysType>(
                    child: Text(value.name!),
                    value: value,
                  );
                }).toList(),
                onChanged: (SysType? value) {
                  setState(() {
                    transactionType = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),
            // const SizedBox(height: 5,),
            text('Cheque No'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: chequeNoController,
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
            const SizedBox(height: 7,),
            text('Date'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: "dd-mm-yyyy",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  )),
            ),
            // const SizedBox(
            //   height: 7,
            // ),
            const SizedBox(
              height: 7,
            ),
            text('Bank Name'),
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
                value: bankType,
                hint: const Text(
                  'Select Bank Name',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: bankTypeList.map<DropdownMenuItem<SysType>>((SysType value) {
                  return DropdownMenuItem<SysType>(
                    child: Text(value.name!),
                    value: value,
                  );
                }).toList(),
                onChanged: (SysType? value) {
                  setState(() {
                    bankType = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),
            text('Bill No.'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: billNoController,
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
            TextFormField(
              controller: remarksController,
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
              onTap: () async {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Dashboard()));
                final ImagePicker _picker = ImagePicker();
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                File photofile = File(photo!.path);
                Uint8List imagebytes = await photofile.readAsBytes(); //convert to bytes
                setState(() {
                  buffer = base64.encode(imagebytes);
                });
              },
              child: Container(
                child: const Center(
                  child: Text(
                    'Camera',
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Dashboard()));
                setState(() {
                  isButtonLoading = true;
                });
                _saveCollection();
              },
              child: isButtonLoading?
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
