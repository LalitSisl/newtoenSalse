import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salesapp/Daily_Report/daily_report.dart';
import 'package:salesapp/Dashboard/home.dart';
import 'package:salesapp/FDFM/create_fdfm.dart';
import 'package:salesapp/FDFM/view_fdfm.dart';
import 'package:salesapp/Menu/customers.dart';
import 'package:salesapp/Menu/daily_calles.dart';
import 'package:salesapp/Menu/expenses.dart';
import 'package:salesapp/Menu/follow_up.dart';
import 'package:salesapp/Menu/future_plan.dart';
import 'package:salesapp/Menu/product.dart';
import 'package:salesapp/Menu/report.dart';
import 'package:salesapp/Menu/scheme.dart';
import 'package:salesapp/Menu/survey.dart';
import 'package:salesapp/Menu/target.dart';
import 'package:salesapp/notification.dart';
import 'package:salesapp/order.dart';
import 'package:salesapp/price_list.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/utils/secure_storage.dart';
import 'package:xml2json/xml2json.dart';
import '../Authentication/login.dart';
import '../Menu/event.dart';
import '../Network/api.dart';

class Dashboard extends StatefulWidget {
  String user;
   Dashboard({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool _show = false;
  var staffCode;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    PriceList(),
    Order(),
    NotificationScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future getStaffCode() async {

    // SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
      staffuser= await UserSecureStorage().getuser();
     });
    print("staff id -----> $staffuser");

  }
  var createfdfm;
  var fdfmData;
  var staffuser;
  getViewFDFM() async{


     String fdfmData1=await UserSecureStorage().getBodyHeader();
     String createfdfm=await UserSecureStorage().getfdfmcreate();

     fdfmData=jsonDecode(fdfmData1);
     print("fdfm data is $fdfmData");



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffCode();
    getViewFDFM();
  }
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title:  FittedBox(
          child:

          Text(
            'Hi ${widget.user}',
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 10, 10, 10)),
          ),
        ),
        actions: [


          GestureDetector(
            onTap: () {

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewFDFM()
                ));
              },

            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child:

              Image.asset(
                'assets/images/file.png',
                scale: 1.3,
                width:20,
                height: 50,
                // color: Colors.blueAccent,
              ),
            ),
          ),
          const  SizedBox(width: 10,),

          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        child: SizedBox(
                            height: 120,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Confirmation",
                                    style: TextStyle(color: Colors.blue),
                                  ),

                                  const Text(
                                    "Are you Sure for Download FDFM",
                                  ),

                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              downloadFDFM();
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Image.asset(
                'assets/images/download.png',
                scale: 2.3,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateFDFM()));
             // getViewFDFM();
            },
            child: const CircleAvatar(
                radius: 11,
                child: Icon(
                  Icons.add,
                  size: 18,
                )),
          ),
          GestureDetector(
            onTap: () {
              showBottomSheet();
            },
            child: Image.asset(
              'assets/images/menu.png',
              scale: 2.5,
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 148, 68, 62),
                  size: 25,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/money.png',
                  scale: 4,
                  color: const Color.fromARGB(255, 148, 68, 62),
                ),
                label: 'Price List',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/order.png',
                  scale: 4,
                  color: const Color.fromARGB(255, 148, 68, 62),
                ),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/notification.png',
                  scale: 1.8,
                  color: const Color.fromARGB(255, 135, 66, 61),
                ),
                label: 'Notification',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            // selectedItemColor: Colors.black,
            // unselectedItemColor: Colors.black,
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 0),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               GestureDetector(
              //                 onTap: () {},
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     Image.asset('assets/images/about.png',
              //                         scale: 3.2,
              //                         color: const Color.fromARGB(
              //                             255, 105, 160, 206)),
              //                     const SizedBox(
              //                       height: 5,
              //                     ),
              //                     const Text(
              //                       'About Newton',
              //                       style: TextStyle(
              //                         fontSize: 12,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 20,
              //               ),
              //               GestureDetector(
              //                 onTap: () {},
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: const [
              //                     Icon(
              //                       Icons.logout,
              //                       size: 17,
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       'Logout',
              //                       style: TextStyle(
              //                         fontSize: 12,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ]),
              // ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: const Text(
                      'Sales Activity',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DailyReport()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/dailyreport.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Daily Report',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Event()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/event.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Event',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Expenses()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/expenses.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Expenses',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Product()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/about.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Products',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Target()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Image(
                                  image: AssetImage(
                                    'assets/images/event.png',
                                  ),
                                  height: 20.0,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Targets',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: const Text(
                      'Reports',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/move.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Emp Move',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FollowUp()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/event.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Follow-up',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scheme()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/dailyreport.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Schemes',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Survey()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/event.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Survey',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Customers()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/expenses.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Customers',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Report()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/expenses.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Reports',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DailyCalls()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/about.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Daily Calls',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FuturePlan()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/about.png',
                                      ),
                                      height: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Future Plan',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: const Text(
                      'Newton',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/about.png',
                                    ),
                                    height: 20.0,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'About Newton',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                const FlutterSecureStorage().deleteAll();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (BuildContext context) => const Login()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  downloadFDFM() async {

   // print("user is $user, pass is $pass");
    var res= await http.post(Uri.parse(API.downloadFDFM),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_sUserId":staffCode,
          "_VisitorCode":"101",
          "_TenantCode": "01",
          "_Location":"110001"
        }
    );

 var listcount;
    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode == 200){
      //print(res.body);
      Xml2Json xml2Json=Xml2Json();

      xml2Json.parse(bodyIs);
      var jsonString = xml2Json.toParker();

      //print("xml2Json is ${jsonString}");

      var data = jsonDecode(jsonString);

      var report=data['DataSet'];

      var diff=report['diffgr:diffgram'];

      var newdata =diff['NewDataSet'];

     // var reportIs=jsonDecode(newdata);
      //print("xml2Json is ${reportIs}");
      setState(() {
        listcount = newdata['Table1'];
        print('arrey > ${listcount.length}');
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 10,
                child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "${listcount.length} record Downloaded Successfully",
                            style: TextStyle(color: Colors.blue),
                          ),

                          Center(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.black87),
                                    )),

                              ],
                            ),
                          ),

                        ],
                      ),
                    )),
              ),
            );
          });
    }

    else{
    }
  }
}
