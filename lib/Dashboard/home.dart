import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:salesapp/create_order.dart';
import 'package:salesapp/utils/secure_storage.dart';

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
  }

  var EmpName;
  method() async {
    setState(() async {
      EmpName = await UserSecureStorage().getEmpName();
    });
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
          // const Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 15,
          //   ),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       'Location',
          //       style: TextStyle(),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     height: 45,
          //     child: DropdownButtonFormField<String>(
          //       hint: const Text('Select Location'),
          //       decoration: const InputDecoration(
          //         isDense: true, // Added this
          //         contentPadding:
          //             EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          //         focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(),
          //         ),
          //       ),
          //       value: place,

          //       dropdownColor: Colors.white,
          //       isExpanded: true,

          //       iconSize: 20,
          //       style: const TextStyle(color: Colors.black),

          //       items: [
          //         'In Office',
          //         'In Field',
          //         'Travelling',
          //         'Training',
          //         'WFH',
          //         'External Meeting'
          //       ].map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           child: Text(value),
          //           value: value,
          //         );
          //       }).toList(),
          //       onChanged: (salutation) {
          //         setState(() {
          //           place = salutation;
          //         });
          //       },
          //       //value: dropdownProject,
          //       validator: (value) => value == null ? 'field required' : null,
          //     ),
          //   ),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Check-In'),
              ),
              ElevatedButton(
                onPressed: () {},
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
