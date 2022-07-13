
import 'package:flutter/material.dart';

class AboutNewton extends StatefulWidget {
  const AboutNewton({Key? key}) : super(key: key);

  @override
  State<AboutNewton> createState() => _AboutNewtonState();
}

class _AboutNewtonState extends State<AboutNewton> {
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
          'About Newton',
          style:
          TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
             Text('NEWTON is a flagship product of NIPPON DATA SYSTEM LIMITED, a leading service provider of ERP, CRM and SCM solutions. We are committed to delivering high quality products and services. We work with customers to provide them industry specific solutions. Our business is to make our Customers do more with what they have through our products and services. We take pride in conducting business with the highest degree of ethics and treat each transaction with fairness and honesty. This promise motivates us to innovate, perform and excel.  and this, we believe, is the foundation of success of all stake holders - employees, customers and shareholders. '
              ,style: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w700),),
         SizedBox(height: 25,),
            Text('COPY RIGHT 2015 BY NIPPON DATA SYSTEM LTD',style: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w700),)
          ],
        ),
      ),
    );
  }
}
