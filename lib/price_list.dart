import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

// import 'Models/zone_code_model.dart';
import 'Models/product_type.dart';
import 'Models/sys_type.dart';
import 'Network/api.dart';

class PriceList extends StatefulWidget {
  PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {

  SysType zone = SysType();
  List<SysType> zoneList = [];
  SysType product = SysType();
  List<SysType> productList = [];
  ProductType productType = ProductType();
  List<ProductType> productTypeList = [];
  bool isLoading = true;

  _getZone() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType':'ZONE_CODE',
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
          zoneList.add(SysType.fromJson(v));
        });
        zone = zoneList[0];
        // isLoading = false;
      });
    }
    else{
      // setState(() {
      //   isLoading = false;
      // });
    }
    _getProducts();
  }

  _getProducts() async {
    var res= await http.post(Uri.parse(API.WS_Get_Syscode_Values),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          '_SysCodeType':'PRODUCT_CODE',
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
      var productObject=data['string'];
      productObject = productObject.toString().replaceAll("\\r\\\\n", "\n");
      var object = json.decode(productObject.toString());
      setState(() {
        object['SysType'].forEach((v) {
          productList.add(SysType.fromJson(v));
        });
        product = productList[0];
        isLoading = false;
      });
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  _getProductType() async {
    var res= await http.post(Uri.parse(API.WS_Get_Product_Type),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          'Product_Code':'${product.value}'
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
        object['Product_Type'].forEach((v) {
          productTypeList.add(ProductType.fromJson(v));
        });
        productType = productTypeList[0];
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
    _getZone();
  }
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {

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

        date.text=formattedDate.toString();


      });
    }

  }
  TextEditingController date=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 7,
                ),
                text('Zone'),
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
                    value: zone,
                    hint: const Text(
                      'Select Zone',
                      style: TextStyle(fontSize: 13),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    iconSize: 20,
                    style: const TextStyle(color: Colors.black),
                    items: zoneList.map<DropdownMenuItem<SysType>>((SysType value) {
                      return DropdownMenuItem<SysType>(
                        child: Text(value.name!),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (SysType? value) {
                      setState(() {
                        zone = value!;
                      });
                    },
                    //value: dropdownProject,
                    validator: (value) => value == null ? 'field required' : null,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Products'),
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
                    value: product,
                    hint: const Text(
                      'Select Product',
                      style: TextStyle(fontSize: 13),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    iconSize: 20,
                    style: TextStyle(color: Colors.black),
                    items: productList.map<DropdownMenuItem<SysType>>((SysType value) {
                      return DropdownMenuItem<SysType>(
                        child: Text(value.name!),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (SysType? value) {
                      setState(() {
                        product = value!;
                      });
                      _getProductType();
                    },
                    //value: dropdownProject,
                    validator: (value) => value == null ? 'field required' : null,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                text('Product Type'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: DropdownButtonFormField<ProductType>(
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
                    value: productType,
                    hint: const Text(
                      'Select Product Type',
                      style: TextStyle(fontSize: 13),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,

                    iconSize: 20,
                    style: TextStyle(color: Colors.black),

                    items: productTypeList.map<DropdownMenuItem<ProductType>>((ProductType value) {
                      return DropdownMenuItem<ProductType>(
                        child: Text(value.pRODTYPEDesc!),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (ProductType? value) {
                      setState(() {
                        productType = value!;
                      });
                    },
                    //value: dropdownProject,
                    validator: (value) => value == null ? 'field required' : null,
                  ),
                ),
                text('WEF Date'),
                const SizedBox(
                  height: 5,
                ),
                 TextField(
                  controller: date,
                  onTap: (){
                    _selectDate(context);
                  },
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
                        'Fetch Record',
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
          children: const [
            TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ))
          ]),
    );
  }
}
