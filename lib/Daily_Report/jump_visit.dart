import 'package:flutter/material.dart';
import 'package:salesapp/Jump_Visit/existing.dart';
import 'package:salesapp/Jump_Visit/lead.dart';
import 'package:salesapp/Jump_Visit/new.dart';

class JumpVisit extends StatefulWidget {
  const JumpVisit({Key? key}) : super(key: key);

  @override
  State<JumpVisit> createState() => _JumpVisitState();
}

class _JumpVisitState extends State<JumpVisit> {
  int _selectedIndex = 0;
  bool _show = false;
  static List<Widget> _widgetOptions = <Widget>[
    Existing(),
    New(),
    Lead()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          'Jump Visit',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
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
                label: 'Existing Customer',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/money.png',
                  scale: 4,
                  color: const Color.fromARGB(255, 148, 68, 62),
                ),
                label: 'New Customer',
              ),

              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/money.png',
                  scale: 4,
                  color: const Color.fromARGB(255, 135, 66, 61),
                ),
                label: 'Lead Customer',
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
}
