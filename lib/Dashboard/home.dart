import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesapp/create_order.dart';
import 'package:salesapp/utils/secure_storage.dart';
import '../Network/api.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final _calendarControllerToday = AdvancedCalendarController.today();
  final List<DateTime> events = [
    DateTime.utc(2021, 08, 10, 12),
    DateTime.utc(2021, 08, 11, 12)
  ];
  var place;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method();
    getStaffCode();
  }
  var staffCode;
  Future getStaffCode() async {
    setState(() async {
      staffCode= await UserSecureStorage().getStaffId();
    });

  }

  var EmpName;
  method() async {
    setState(() async {
      EmpName = await UserSecureStorage().getEmpName();
    });
  }

  _checkIn() async {
    var res= await http.post(Uri.parse(API.Ws_Day_Check_In),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_StaffId":staffCode,
          "_VisitCode":"101",
          "_TenantCode": "01",
          "_Location":"110001"
        }
    );
    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Checked In Successfully"),
      ));
    }
    else{}
  }

  _checkOut() async {
    var res= await http.post(Uri.parse(API.Ws_Day_Check_Out),headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
        body: {
          "_StaffId":staffCode,
          "_VisitCode":"101",
          "_TenantCode": "01",
          "_Location":"110001"
        }
    );
    var bodyIs=res.body;
    var statusCode=res.statusCode;
    if(statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Checked Out Successfully"),
      ));
    }
    else{}
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdvancedCalendar(
                controller: _calendarControllerToday,
                events: events,
                startWeekDay: 1,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'No Activity for this day',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateOrder()));
            },
            child: const Text(
              'Create Order',
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 117, 189),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Attendance',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {_checkIn();},
                child: const Text('Check-In'),
              ),
              ElevatedButton(
                onPressed: () {_checkOut();},
                child: const Text('Check-Out'),
              ),
            ],
          ),
        ]),
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
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Nominee()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/nominee.png',
                              scale: 2.1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Nominee')
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/incom.png',
                            scale: 2.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Income Tax')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/salary.png',
                            scale: 2.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Salary/TDS')
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/pay.png',
                            scale: 0.5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Pay Slip')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Policy()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/policy.png',
                              scale: 1.8,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Policies')
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LeaveApproval()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/leave.png',
                              scale: 0.7,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Leave Approval')
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
