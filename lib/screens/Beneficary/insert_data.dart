import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Beneficary/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/Authentication/home_page.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Beneficaries');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            )
          },
          child: const Text('Helping Hands'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Insert Beneficiary Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Beneficiary Name *',
                  hintText: 'Enter Beneficiary Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Beneficiary Address *',
                  hintText: 'Enter Beneficiary Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Beneficiary Email Address *',
                  hintText: 'Enter Beneficiary Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else if (!value.contains('@')) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Beneficiary Phone Number *',
                  hintText: 'Enter Beneficiary Phone Number',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else if (value.length < 10) {
                    return "Please enter a valid phone number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Beneficiary Description',
                  hintText: 'Enter Beneficiary Description',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> beneficaries = {
                      'Beneficary_Name': nameController.text,
                      'Beneficary_Address': addressController.text,
                      'Beneficary_Email': emailController.text,
                      'Beneficary_Phone': phoneController.text,
                      'Beneficary_Description': descriptionController.text
                    };

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              dbRef.push().set(beneficaries);

                              Fluttertoast.showToast(
                                msg: "Data Added Successfully!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.grey,
                                textColor: Colors.black,
                                fontSize: 15,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BeneficaryHomePage()),
                              );
                            },
                            child: Text('Yes'),
                          ),
                        ],
                        title: const Text('Alert'),
                        contentPadding: const EdgeInsets.all(20.0),
                        content: const Text('Do You Want To Insert Data ?'),
                      ),
                    );
                  }
                },
                child: const Text('Insert Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
