
import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
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
          'Instructions',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 166, 207, 240),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://img.icons8.com/office/2x/circled-up.png"),
                              //whatever image you can put here
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        text('Dear Jagveer'),
                        const SizedBox(
                          height: 10,
                        ),
                        text('There is a new lead posted with remarks'),
                        const SizedBox(
                          height: 10,
                        ),
                        text('Please see the lead.'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text('Jagveer'),
                            text('18-08-2019'),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Widget text(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
    );
  }
}
