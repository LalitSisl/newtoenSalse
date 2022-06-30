import 'package:flutter/material.dart';
class RetailerSummary extends StatefulWidget {
  const RetailerSummary({Key? key}) : super(key: key);

  @override
  State<RetailerSummary> createState() => _RetailerSummaryState();
}

class _RetailerSummaryState extends State<RetailerSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Retailer summary',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),

      ),
    );
  }
}
