import 'package:flutter/material.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  var type;
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
          'Create Order',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('Customer Name'),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    enabled: false,
                    decoration: InputDecoration(

                      hintText: 'DELHI 500005',
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

                        )

                    ),

                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Item List'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      value: type,
                      hint: const Text(
                        'Select',
                        style: TextStyle(fontSize: 13),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,

                      iconSize: 20,
                      style: TextStyle(color: Colors.black),

                      items: [
                        'ACRYLIC',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'DOOR SKIN',
                        'EMBOSSED',
                        'EMBOSSED',
                        'EMBOSSED',
                        'EMBOSSED',
                        'EMBOSSED',
                        'EMBOSSED',
                        'HDHMR DOOR',
                        'HDHMR DOOR',
                        'HDHMR DOOR',
                        'HDF/HDHMR',
                        'HDF/HDHMR',
                        'HDF/HDHMR',
                        'HDF/HDHMR',
                        'FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'VALUE ADDES FLOORING',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',
                        'ACCESSORIES',

                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {
                          type = salutation;
                        });
                      },
                      //value: dropdownProject,
                      validator: (value) =>
                          value == null ? 'field required' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  text('Item Price'),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(
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
                    height: 7,
                  ),
                  text('Item Quantity'),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(
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
                    height: 7,
                  ),
                  text('Amount'),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(
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
                    height: 7,
                  ),
                  text('Remarks'),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Order Successfully Created "),
                      ));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Dashboard()));
                    },
                    child: Container(
                      child: const Center(
                        child: Text(
                          'Save',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 16, 36, 53),
                      ),
                      height: 45,
                    ),
                  ),
                ])),
      ),
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
