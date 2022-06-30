import 'package:flutter/material.dart';
class StockView extends StatefulWidget {
  const StockView({Key? key}) : super(key: key);

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
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
          'Stock View',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),

      ),
    );
  }
}
