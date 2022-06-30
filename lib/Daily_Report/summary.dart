import 'package:flutter/material.dart';
import 'package:salesapp/Daily_Report/visit_notes.dart';

import '../order.dart';
import 'collections.dart';
import 'instructions.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
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
          'Summary',
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
                    child: frame('3 Month Sales', "https://img.icons8.com/external-linector-lineal-color-linector/344/external-order-online-shopping-linector-lineal-color-linector.png")),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VisitNotes()));
                    },
                    child: frame('Past Order',"https://img.icons8.com/fluency/344/attendance-mark.png")),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Collections()));
                    },
                    child: frame('Past Visit Notes',"https://img.icons8.com/dotty/344/add-to-database.png")),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Instructions()));
                    },
                    child: frame('Follow-Up',"https://img.icons8.com/external-prettycons-flat-prettycons/2x/external-instructions-office-prettycons-flat-prettycons.png")),
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
