import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salesapp/Menu/complaint_view.dart';
import 'package:salesapp/Menu/retailer.dart';
import 'package:salesapp/Menu/sales_return.dart';
import 'package:salesapp/Menu/stock_view.dart';
import 'package:salesapp/Menu/visit_note.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
          'Report',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StockView()));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/event.png',
                              scale: 1.5,
                              color: const Color.fromARGB(
                                  255, 105, 160, 206)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Stock View',
                            style: TextStyle(
                              fontSize: 12,

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SalesReturn()));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/event.png',
                              scale: 1.5,
                              color: const Color.fromARGB(
                                  255, 105, 160, 206)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Sales Return View',
                            style: TextStyle(
                              fontSize: 12,

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RetailerSummary()));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/event.png',
                              scale: 1.5,
                              color: const Color.fromARGB(
                                  255, 105, 160, 206)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Retailer summary',
                            style: TextStyle(
                              fontSize: 12,

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintView()));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/event.png',
                              scale: 1.5,
                              color: const Color.fromARGB(
                                  255, 105, 160, 206)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Complaint View',
                            style: TextStyle(
                              fontSize: 12,

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VisitNote()));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/event.png',
                              scale: 1.5,
                              color: const Color.fromARGB(
                                  255, 105, 160, 206)),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Visit Note View',
                            style: TextStyle(
                              fontSize: 12,

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
