
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import '../Models/sys_type.dart';
import '../Network/api.dart';
import '../utils/secure_storage.dart';

class Follow extends StatefulWidget {
  const Follow({Key? key}) : super(key: key);

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  bool isLoading = true;
  bool isButtonLoading = false;
  List<SysType> followUpTypeList = <SysType>[];
  SysType followUpType = SysType();
  var nextFollowDateController = TextEditingController();
  var followDateController = TextEditingController();
  var remarksController = TextEditingController();
  // Position? position;

  _getFollowUpType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "NEWTON_FOLLOWUP_TYPE",
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
          followUpTypeList.add(SysType.fromJson(v));
        });
        followUpType = followUpTypeList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _saveFollowUp() async {
    // position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Stock_Update),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId': "$staffId",
          '_PartyCode':"",
          '_Remarks': remarksController.text,
          '_Sdate': followDateController.text,
          '_VisitType': "${followUpType.value}",
          '_NextFollowup_Date': nextFollowDateController.text,
          'markssid': "",
          // '_GprsLatitude': "${position!.latitude}",
          // '_GprsLongTude': "${position!.longitude}",
          '_GprsLatitude':'28.144858',
          '_GprsLongTude': '77.232342',
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
        Fluttertoast.showToast(msg: "Follow Up Saved");
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
    _getFollowUpType();
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
          'Follow_UP',
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
            text('Next Follow-up Date'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: nextFollowDateController,
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
            text('Follow-up Date'),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: followDateController,
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
              height: 7,
            ),
            text('Follow-up Type'),
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
                value: followUpType,
                hint: const Text(
                  'Select Item',
                  style: TextStyle(fontSize: 13),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: TextStyle(color: Colors.black),

                items: followUpTypeList.map<DropdownMenuItem<SysType>>((SysType value) {
                  return DropdownMenuItem<SysType>(
                    child: Text(value.name!),
                    value: value,
                  );
                }).toList(),
                onChanged: (SysType? value) {
                  setState(() {
                    followUpType = value!;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
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
                _saveFollowUp();
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
