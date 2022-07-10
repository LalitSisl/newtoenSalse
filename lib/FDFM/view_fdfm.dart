import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/FDFM/FDFMBean.dart';
import 'package:salesapp/utils/secure_storage.dart';

class ViewFDFM extends StatefulWidget {
  const ViewFDFM({Key? key}) : super(key: key);

  @override
  State<ViewFDFM> createState() => _ViewFDFMState();
}


class _ViewFDFMState extends State<ViewFDFM> {
  var fdfmData;


  getViewFDFM() async{
    String fdfmData1= await UserSecureStorage().getBodyHeader();
    setState(() {
      fdfmData=jsonDecode(fdfmData1);

      print("view fdfmData is $fdfmData");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getViewFDFM();
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
          'View FDFM',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body:fdfmData==null? Container() :
     ListView.builder(
    itemCount: fdfmData.length,
      itemBuilder: (BuildContext context, int index) {

        var data=fdfmData.elementAt(index);
        var res=data["_StaffID"];
        print("res is $res");
        return Card(
          color: Color.fromARGB(100, 100, 100, 100),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("StaffID:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_StaffID"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("Mobile:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_Mobile"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("PlanDate:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_PlanDate"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("Client:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_Client"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("Dsp:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_DSP"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("City:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["_City"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("PlanDate:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["Supported_By"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("Date:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["Todate"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text("Type:"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(data["type"],textAlign: TextAlign.start,),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    )
    );
  }

 Widget displayView(){

    return ListView.builder(
      itemCount: fdfmData.length,
      itemBuilder: (BuildContext context, int index) {
        String key = fdfmData.keys.elementAt(index);
        var data=fdfmData[key];
        return Column(
          children: <Widget>[

            ListTile(
              title: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = data.keys.elementAt(index);
                 // var data=fdfmData[key];
                  return Row(
                    children: <Widget>[
                      Text("$key"),
                      SizedBox(width: 10,),
                      Text("${fdfmData[key]}"),
                      const Divider(
                        height: 2.0,
                      ),
                    ],
                  );
                },
              ),
              subtitle: Text("${fdfmData[key]}"),
            ),
            const Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

}
