import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  const Survey({Key? key}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int? _groupValue = -1;
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
          'Promotional Survey',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. Are you satisfied with our service?'),
              RadioListTile(
                value: 0,
                groupValue: _groupValue,
                onChanged: (newValue) =>
                    setState(() => _groupValue = newValue as int?),
                title: Text("Yes"),
              ),
              RadioListTile(
                value: 1,
                groupValue: _groupValue,
                onChanged: (newValue) =>
                    setState(() => _groupValue = newValue as int?),
                title: Text("No"),
              ),
              Text('2. How do you rate our schemes and offers?'),
              RadioListTile(
                value: 0,
                groupValue: _groupValue,
                onChanged: (newValue) =>
                    setState(() => _groupValue = newValue as int?),
                title: Text("Yes"),
              ),
              RadioListTile(
                value: 1,
                groupValue: _groupValue,
                onChanged: (newValue) =>
                    setState(() => _groupValue = newValue as int?),
                title: Text("No"),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Enter the comment',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Dashboard()));
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'Save',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 16, 36, 53),
                  ),
                  height: 40,
                ),
              ),
            ],
          )),
    );
  }
}
