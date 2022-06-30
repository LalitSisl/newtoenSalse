
import 'package:flutter/material.dart';
import 'package:salesapp/Daily_Report/collections.dart';
import 'package:salesapp/Daily_Report/competitor.dart';
import 'package:salesapp/Daily_Report/complaint.dart';
import 'package:salesapp/Daily_Report/enquiry.dart';
import 'package:salesapp/Daily_Report/follow.dart';
import 'package:salesapp/Daily_Report/instructions.dart';
import 'package:salesapp/Daily_Report/jump_visit.dart';
import 'package:salesapp/Daily_Report/order.dart';
import 'package:salesapp/Daily_Report/pop.dart';
import 'package:salesapp/Daily_Report/salesreturn.dart';
import 'package:salesapp/Daily_Report/stock.dart';
import 'package:salesapp/Daily_Report/summary.dart';
import 'package:salesapp/Daily_Report/visit_notes.dart';
import 'package:salesapp/Menu/visit_note.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({Key? key}) : super(key: key);

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
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
          'Daily Report',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16),
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
                  },
                  child: frame('Order', "https://img.icons8.com/external-linector-lineal-color-linector/344/external-order-online-shopping-linector-lineal-color-linector.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitNotes()));
                  },
                  child: frame('Visit Notes',"https://img.icons8.com/fluency/344/attendance-mark.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Collections()));
                  },
                  child: frame('Collections',"https://img.icons8.com/dotty/344/add-to-database.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Instructions()));
                  },
                  child: frame('Instructions',"https://img.icons8.com/external-prettycons-flat-prettycons/2x/external-instructions-office-prettycons-flat-prettycons.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StockCapture()));
                  },
                  child: frame('Stock Capture',"https://img.icons8.com/fluency/344/stock-share.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Follow()));
                  },
                  child: frame('Follow-Up',"https://img.icons8.com/office/2x/sort-by-follow-up-date.png")),
              GestureDetector(
                  onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
                  },
                  child: frame('Camera',"https://img.icons8.com/clouds/2x/apple-camera.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Competitor()));
                  },
                  child: frame('Competitor',"https://img.icons8.com/external-soft-fill-juicy-fish/2x/external-competitor-business-strategy-soft-fill-soft-fill-juicy-fish.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Enquiry()));
                  },
                  child: frame('Enquiry',"https://img.icons8.com/color/2x/why-us-male.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Complaint()));
                  },
                  child: frame('Compliant',"https://img.icons8.com/color/2x/complaint.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SalesReturn()));
                  },
                  child: frame('Sales return',"https://img.icons8.com/office/2x/return.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
                  },
                  child: frame('OutStanding',"https://img.icons8.com/external-lylac-kerismaker/2x/external-Outstanding-team-work-lylac-kerismaker.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Summary()));
                  },
                  child: frame('Summary',"https://img.icons8.com/external-sbts2018-outline-color-sbts2018/2x/external-summary-basic-ui-elements-2.4-sbts2018-outline-color-sbts2018.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => POP()));
                  },
                  child: frame('POP',"https://img.icons8.com/fluency/2x/details-popup.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => JumpVisit()));
                  },
                  child: frame('Jump Visit',"https://img.icons8.com/offices/2x/sort-by-start-date.png")),
              GestureDetector(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => JumpVisit()));
                  },
                  child: frame('Client List',"https://img.icons8.com/offices/2x/sort-by-start-date.png")),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Complaint()));
                  },
                  child: frame('Location',"https://img.icons8.com/office/344/marker.png")),
            ]
      )
      ),
    );
  }
  Widget frame(String text, String path){
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(path),
                  //whatever image you can put here
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
