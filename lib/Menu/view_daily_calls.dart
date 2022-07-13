import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/utils/secure_storage.dart';

import '../Models/daily_calls_model.dart';

class ViewDailyCalls extends StatefulWidget {
  const ViewDailyCalls({Key? key}) : super(key: key);

  @override
  State<ViewDailyCalls> createState() => _ViewDailyCallsState();
}

class _ViewDailyCallsState extends State<ViewDailyCalls> {
  bool isLoading = true;
  DailyCallsModel dailyCallsModel = DailyCallsModel();

  Future<void> getDailyCalls() async {
    var dailyCalls = await UserSecureStorage().getDailyCalls();
    print("$dailyCalls");
    print("${jsonDecode(dailyCalls)}");
    // var body = jsonDecode(dailyCalls);
    setState(() {
      dailyCallsModel = DailyCallsModel.fromJson(dailyCalls);
      print("${dailyCallsModel}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDailyCalls();
  }

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
          'Daily Calls View',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),

      ),
      body: isLoading?
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )
          : ListView.builder(
          itemCount: 1,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Date:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(dailyCallsModel.date != null ? '${dailyCallsModel.date}' : '--')),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Sub Area:')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: text(dailyCallsModel.subArea != null ? '${dailyCallsModel.subArea}' : '--')
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Category:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              dailyCallsModel.category != null ?
                              '${dailyCallsModel.category}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Calls Made:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              dailyCallsModel.callsMade != null ?
                              '${dailyCallsModel.callsMade}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Eff. Calls:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              dailyCallsModel.executiveCalls != null ?
                              '${dailyCallsModel.executiveCalls}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Quantity:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              dailyCallsModel.qty != null ?
                              '${dailyCallsModel.qty}' : '--'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: text('Amount:')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: text(
                              dailyCallsModel.amount != null ?
                              '${dailyCallsModel.amount}' : '--'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            // return Container();
          }),
    );
  }

  Widget text(String value) {
    return RichText(
      text: TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
          ),
          children: const [
            TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ))
          ]),
    );
  }
}
