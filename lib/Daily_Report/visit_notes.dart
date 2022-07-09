
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Models/order_item_model.dart';
import '../Models/sys_type.dart';
import '../Network/api.dart';
import 'package:http/http.dart' as http;

class VisitNotes extends StatefulWidget {
  const VisitNotes({Key? key}) : super(key: key);

  @override
  State<VisitNotes> createState() => _VisitNotesState();
}

class _VisitNotesState extends State<VisitNotes> {

  bool isLoading = true;
  bool isButtonLoading = false;
  List<SysType> visitNoteTypeList = <SysType>[];
  SysType visitNoteType = SysType();
  List<OrderItemModel> statusList = <OrderItemModel>[];
  OrderItemModel status = OrderItemModel();
  List<OrderItemModel> leadTypeList = <OrderItemModel>[];
  OrderItemModel leadType = OrderItemModel();
  var remarksController = TextEditingController();

  _getVisitNoteType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_ValuesV2),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType': "VISIT_NOTE_TYPE",
          '_UserName':"userId",
          '_VisitorId':'01',
          '_TenantCode': '101',
          '_Location': '110001',
          'PlanID': 'planIdNew'
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
          visitNoteTypeList.add(SysType.fromJson(v));
        });
        object['Status'].forEach((v) {
          statusList.add(OrderItemModel.fromJson(v));
        });
        object['LeadType'].forEach((v) {
          leadTypeList.add(OrderItemModel.fromJson(v));
        });
        visitNoteType = visitNoteTypeList[0];
        status = statusList[0];
        leadType = leadTypeList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _saveVisitNote() async {
    var staffId = await UserSecureStorage().getStaffId();
    var res= await http.post(Uri.parse(API.Ws_Visit_Note_V3),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_StaffId': "$staffId",
          '_PartyCode':"",
          '_VisitNote':"${visitNoteType.value}",
          '_Remarks': remarksController.text,
          '_VisitCode': '01',
          '_TenantCode': '101',
          '_Location':'110001',
          'markssid':'planIdNew',
          'Status':"${status.sYSCDSCODEVALUE}",
          'Lead_Type':"${leadType.sYSCDSCODEVALUE}"
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
        //   visitNoteTypeList.add(SysType.fromJson(v));
        // });
        // object['Status'].forEach((v) {
        //   statusList.add(OrderItemModel.fromJson(v));
        // });
        // object['LeadType'].forEach((v) {
        //   leadTypeList.add(OrderItemModel.fromJson(v));
        // });
        // visitNoteType = visitNoteTypeList[0];
        // status = statusList[0];
        // leadType = leadTypeList[0];
        Navigator.of(context).pop();
        isButtonLoading = false;
        Fluttertoast.showToast(msg: "Visit Note Saved");
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
    _getVisitNoteType();
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
          'Visit Notes',
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
      text('Visit Note Type'),
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
          value: visitNoteType,
          hint: const Text(
            'Select note',
            style: TextStyle(fontSize: 13),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,

          iconSize: 20,
          style: TextStyle(color: Colors.black),

          items: visitNoteTypeList.map<DropdownMenuItem<SysType>>((SysType value) {
            return DropdownMenuItem<SysType>(
              child: Text(value.name!),
              value: value,
            );
          }).toList(),
          onChanged: (SysType? value) {
            setState(() {
              visitNoteType = value!;
            });
          },
          //value: dropdownProject,
          validator: (value) => value == null ? 'field required' : null,
        ),
      ),
      const SizedBox(height: 7,),
      text('Status'),
      const SizedBox(
        height: 5,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: DropdownButtonFormField<OrderItemModel>(
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
          value: status,
          hint: const Text(
            'Select status',
            style: TextStyle(fontSize: 13),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,

          iconSize: 20,
          style: TextStyle(color: Colors.black),

          items: statusList.map<DropdownMenuItem<OrderItemModel>>((OrderItemModel value) {
            return DropdownMenuItem<OrderItemModel>(
              child: Text(value.sYSCDSCODEDESC!),
              value: value,
            );
          }).toList(),
          onChanged: (OrderItemModel? value) {
            setState(() {
              status = value!;
            });
          },
          //value: dropdownProject,
          validator: (value) => value == null ? 'field required' : null,
        ),
      ),
      const SizedBox(height: 7,),
      text('Lead Type'),
      const SizedBox(
        height: 5,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: DropdownButtonFormField<OrderItemModel>(
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
          value: leadType,
          hint: const Text(
            'Select Lead',
            style: TextStyle(fontSize: 13),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,

          iconSize: 20,
          style: TextStyle(color: Colors.black),

          items: leadTypeList.map<DropdownMenuItem<OrderItemModel>>((OrderItemModel value) {
            return DropdownMenuItem<OrderItemModel>(
              child: Text(value.sYSCDSCODEDESC!),
              value: value,
            );
          }).toList(),
          onChanged: (OrderItemModel? value) {
            setState(() {
              leadType = value!;
            });
          },
          //value: dropdownProject,
          validator: (value) => value == null ? 'field required' : null,
        ),
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
      isButtonLoading ?
      Container(
        padding: EdgeInsets.all(5.0),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 16, 36, 53),
        ),
        height: 40,
      ) :
      GestureDetector(
        onTap: () {
          setState(() {
            isButtonLoading = true;
          });
          _saveVisitNote();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const Dashboard()));
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
