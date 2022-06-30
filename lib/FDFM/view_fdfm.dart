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
          child: Column(
            children: <Widget>[

              Text("StaffID:         "+ data["_StaffID"]),
              Text("Mobile :         "+ data['_Mobile']),
              Text("PlanDate :       "+ data['_PlanDate']),
              Text("Client :         "+ data['_Client']),
              Text("Dsp :            "+ data['_DSP']),
              Text("Mobile :         "+ data['_City']),
              Text("PlanDate :       "+ data['Supported_By']),
              Text("Client :         "+ data['Todate']),
              Text("Type :           "+ data['type']),

            ],
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
