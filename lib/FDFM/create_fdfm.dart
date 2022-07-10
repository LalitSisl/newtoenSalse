//import 'dart:html';

//import 'dart:_internal';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/FDFM/CitiesList.dart';
import 'package:salesapp/FDFM/FDFMBean.dart';
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';

import '../Network/api.dart';
//import 'package:xml2json/xml2json.dart';

class CreateFDFM extends StatefulWidget {
  const CreateFDFM({Key? key}) : super(key: key);

  @override
  State<CreateFDFM> createState() => _CreateFDFMState();
}

class _CreateFDFMState extends State<CreateFDFM> {
  final _formKey = GlobalKey<FormState>();

  var cityList,cityTable=[],companyList,companyDetails=[],supportList,supportDetails=[],contact_person="";

  String staffCode="";
  bool isButtonLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();

    getStaffCode();
    // getCompanyTList();
    // getSupportList();

  }

  var type;
  var city,cityCode;
  var company,contact,companyt,roleCode="",mobileNumber;
  var contect;
  var support,supportCode;
     // String companyt="";
    //  var selectedDate;
  DateTime selectedDate = DateTime.now();

  TextEditingController startdc=TextEditingController();
  TextEditingController enddc=TextEditingController();
  TextEditingController staffController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController contactPerson=TextEditingController();

  getStaffCode() async{

    setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
      staffController.text=staffCode;
    });


  }

  _selectDate(BuildContext context,String dateType) async {

    DatePickerMode initialDatePickerMode1= DatePickerMode.day;
    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: initialDatePickerMode1 ,
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),

    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var formattedDate=  dateFormat.format(selectedDate);
      if(dateType.contains("start")) {
        startdc.text=formattedDate.toString();
      } else{
        enddc.text=formattedDate.toString();
      }
      });
    }

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
          'Create FDFM',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Form(
          key: _formKey,
         child:

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                           text("Start Date"),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: TextField(
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
                                    )),
                                controller: startdc,
                                onTap: (){
                                  _selectDate(context,"start");
                                },
                              ),
                            ),
                          ],
                        ),
                      SizedBox(width:10),
                      Column(
                        children: [
                          text("End Date"),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: TextField(

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
                                  )),
                              controller: enddc,
                              onTap: (){
                                _selectDate(context,"end");
                              },
                            ),
                          ),
                        ],
                      ),
                        ],
                      ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Staff Member'),
                  const SizedBox(
                    height: 5,
                  ),
                   TextField(
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

                    controller: staffController,

                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Mobile'),
                  const SizedBox(
                    height: 5,
                  ),
                   TextField(
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

                    controller: mobileController,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Type'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: DropdownButtonFormField<String>(
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
                      value: type,
                      hint: const Text(
                        'Select Type',
                        style: TextStyle(fontSize: 13),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),

                      items: [
                        'Normal Plan',
                        'EXHB and Survey',
                        'Telephonic',
                        'Video Call',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {
                          type = salutation;
                        });
                      },
                      //value: dropdownProject,
                      validator: (value) => value == null ? 'field required' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('City'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child:
                    //getDropDownMenuItems(cityTable),

                    DropdownButtonFormField<dynamic>(
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
                     // value: city,
                      hint: const Text(
                        'Select City',
                        style: TextStyle(fontSize: 13),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),

                      items: cityTable.map<DropdownMenuItem<dynamic>>((dynamic value) {
                        var val1=value["NAME"];
                        cityCode=value["CODE"];
                        return DropdownMenuItem<dynamic>(
                          child: Text(val1.toString()),
                          value: cityCode,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {
                        //  print("val1 is $salutation");
                         // city = salutation["NAME"];
                         // cityCode=salutation["CODE"];
                          cityCode=salutation;
                          getCompanyTList(cityCode);
                         // getSupportList(roleCode);
                          print("cityCode is ${salutation}");
                        });
                      },

                      //value: dropdownProject,
                      validator: (value) => value == null ? 'field required' : null,

                    ),

                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Companyt name'),
                  const SizedBox(
                    height: 5,
                  ),
                    SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child:
                    DropdownButtonFormField<dynamic>(
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
                    //  value: companyt,
                      hint: const Text(
                        'Select Company',
                        style: TextStyle(fontSize: 13),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),

                    items:  companyDetails.map<DropdownMenuItem<dynamic>>((dynamic value) {
                      var name=value["NAME"];
                      var companyCode=value["CODE"];
                      var cPerson=value["C_person"];

                    cPerson ??= "hello";
                      var comData=companyCode+"@"+cPerson;

                        return DropdownMenuItem<dynamic>(
                          child: Text(name),
                        //  value: companyCode,
                          value: comData,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {

                          getContactName(salutation);


                        //  print("cData is $cData1");
                         // contact_person=cData[1];
                        });
                      },
                      //value: dropdownProject,
                      validator: (comData) => comData == null ? 'field required' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Contact Person'),
                  const SizedBox(
                    height: 5,
                  ),
                   TextField(
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
                        )),
                    controller: contactPerson,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Support By'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child:
                    DropdownButtonFormField<dynamic>(
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
                      value: support,
                      hint: const Text(
                        'Select',
                        style: TextStyle(fontSize: 13),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,

                      iconSize: 20,
                      style: TextStyle(color: Colors.black),

                      items: supportDetails.map<DropdownMenuItem<dynamic>>((dynamic value) {
                        var supportValue=value["SYSCDS_CODE_DESC"];//SYSCDS_CODE_VALUE
                        var syscodeValue=value["SYSCDS_CODE_VALUE"];

                        return DropdownMenuItem<dynamic>(
                          child: Text(supportValue),
                          value: syscodeValue,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {
                          support = salutation;
                        });
                      },
                      //value: dropdownProject,
                      validator: (support) => support == null ? 'field required' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isButtonLoading = true;
                      });
                      createFDFM(staffCode, mobileController.text, startdc.text, companyt, contactPerson.text, cityCode, support, enddc.text, type);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Dashboard()));

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
                      height: 45,
                    ):
                    Container(
                      child: const Center(
                        child: Text(
                          'Save',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 16, 36, 53),
                      ),
                      height: 45,
                    ),
                  ),

                    ],
                  ),
          ),

        ),
        ),

    );
  }

  getContactName(String comData){

    setState(() {

      var index=comData.indexOf("@");
      var index2=comData.length;
      var cData1=comData.substring(0,index);
      var cData= comData.substring(index+1, index2);
      companyt = cData1;
      contactPerson.text=cData;

    });


  }

  getDropDownMenuItems(snapshot) {
    Map<dynamic, dynamic> mapWithIndex = snapshot.asMap;
    List<DropdownMenuItem> _items = [];
    mapWithIndex.forEach((index, item) {
      _items.add(
        DropdownMenuItem<dynamic>(
          value: index,
          child: Text(item.NAME),
        ),
      );
    });
    return _items;
  }


  Widget text(String value) {
    return RichText(
      text: TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
          ),
          children: const [
            TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ))
          ]),
    );
  }

  getCityList() async{

   // var cityRes=h

    var res= await http.post(Uri.parse(API.Ws_Create_FDFM_CITY_DETAILS),
        headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {

      "_StaffID":"j00080",

    }
    );

  //  print("res body  is ${res.body}");

    var cityRes=res.body;
    var startIndex=cityRes.indexOf("{");
    var endIndex=cityRes.indexOf("</string>");
    // setState(() {
      cityList=cityRes.substring(startIndex, endIndex);
    // });
  //  var cityList=cityRes.substring(startIndex, endIndex-1);
   // print("res after substring $cityList");
    Map cityListMap=json.decode(cityList);
 //   print("city list table1 is ${cityListMap["Table1"]}");
    setState(() {

      cityTable=cityListMap["Table1"];

      var staff_Details=cityListMap["Staff_Details"];

      for(var array in staff_Details){
        roleCode=array['ROLE'];
        setState(() {
          mobileController.text=array['EMPL_MOBILE_NO'];
        });

        getSupportList(roleCode);
     //   print(" array is $roleCode");

      }


    });

//     cityTable.values.forEach((value) {
//       print(value);
//     });

  }

  getCompanyTList(String cityCode) async{

    // var cityRes=h

    var res= await http.post(Uri.parse(API.Ws_Create_FDFM_STAFF_CITY_COMPANY_NAME),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
      "StaffID":"j00080",
          "CityID":cityCode
        }
    );

    print("res body  is ${res.body}");

    var cityRes=res.body;
    var startIndex=cityRes.indexOf("{");
    var endIndex=cityRes.indexOf("</string>");
    // setState(() {
    companyList=cityRes.substring(startIndex, endIndex);
    // });
    //  var cityList=cityRes.substring(startIndex, endIndex-1);
    companyList=companyList;
    print("res after substring $companyList");
    Map companyListMap=json.decode(companyList);
    print("CompanyDetails is ${companyListMap["CompanyDetails"]}");
    setState(() {
      companyDetails=companyListMap["CompanyDetails"];
    });
    // Map cityTable=cityListMap["Table1"];
// print("cityTable is");
//     cityTable.values.forEach((value) {
//       print(value);
//     });

  }

  getSupportList(String roleCode) async{

    // var cityRes=h

    var res= await http.post(Uri.parse(API.Ws_Create_FDFM_STAFF_SupportedBy),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
        "_StaffID":"j00080",
        "ROLEID":roleCode
    }
    );

    print("res body  is ${res.body}");

    var cityRes=res.body;
    var startIndex=cityRes.indexOf("{");
    var endIndex=cityRes.indexOf("</string>");
    // setState(() {
    supportList=cityRes.substring(startIndex, endIndex);
    // });
    //  var cityList=cityRes.substring(startIndex, endIndex-1);
   // print("res after substring $cityList");
    Map supportListMap=json.decode(supportList);
  //  print("city list table1 is ${cityListMap["Table1"]}");

    setState(() {
      supportDetails=supportListMap["SupportBy"];
    });
   // supportListMap["Staff_Details"];
    // Map cityTable=cityListMap["Table1"];
// print("cityTable is");
//     cityTable.values.forEach((value) {
//       print(value);
//     });

  }

  createFDFM(String staffID, String mobile,String planDate,String client,String dsp,String city,

      String supportedBy,String toDate,String type) async{

    print(" fdfm is $staffID $mobile $planDate $client $dsp $city $supportedBy $toDate $type ");
    Map mapData=Map();

    var bodyHeader={
      "_StaffID":staffID,
      "_Mobile":mobile,
      "_PlanDate":planDate,
      "_Client":client,
      "_DSP":dsp,
      "_City":city,
      "Supported_By":supportedBy,
      "Todate":toDate,
      "FirmType":"",
      "type":type
    };

    var res= await http.post(Uri.parse(API.Ws_Create_FDFM_New_v2),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: bodyHeader
    );

    print("fdfm response is ${res.body}");
    var resBody=res.body;
    Xml2Json createRes=Xml2Json();
    createRes.parse(resBody);
    var parseRes= createRes.toParker();
    print("fdfm response is $parseRes");
    var jsondecode=jsonDecode(parseRes);
   var createFdfmStatus= jsondecode["boolean"];

  if(createFdfmStatus=="true"){
  var list=[];

  // list.add(staffID);list.add(mobile);list.add(planDate);list.add(client);list.add(dsp);list.add(city);
  // list.add(supportedBy);list.add(toDate);list.add(type);


  FDFMBean fb=FDFMBean.fromJson(bodyHeader);

  list.add(fb);

 // var bodyStr=jsonEncode(list);

  var bodyStr=json.encode(list);

  await UserSecureStorage().setBodyHeader(bodyStr);
  Fluttertoast.showToast(msg: "FDFM created successfully");
  setState(() {
    Navigator.pop(context,true);
  });


}

  else{

  }

  }


}
