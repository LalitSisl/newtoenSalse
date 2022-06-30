import 'package:flutter/material.dart';

class OutStanding extends StatefulWidget {
  const OutStanding({Key? key}) : super(key: key);

  @override
  State<OutStanding> createState() => _OutStandingState();
}

class _OutStandingState extends State<OutStanding> {
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
          'OutStanding',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
    );
  }
}
