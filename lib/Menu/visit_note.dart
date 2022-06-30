import 'package:flutter/material.dart';
class VisitNote extends StatefulWidget {
  const VisitNote({Key? key}) : super(key: key);

  @override
  State<VisitNote> createState() => _VisitNoteState();
}

class _VisitNoteState extends State<VisitNote> {
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
          'Visit Note View',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    ]),
      ),
    );
  }
}
