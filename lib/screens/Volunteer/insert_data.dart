import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Volunteer/dashboard.dart';
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
  final nicController = TextEditingController();
  final phoneController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Volunteers');
  }

  final _formKey = GlobalKey<FormState>();

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
                'Insert Volunteer Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Name',
                  hintText: 'Enter Volunteer Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Field Cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Address',
                  hintText: 'Enter Volunteer Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Field Cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Email',
                  hintText: 'Enter Volunteer Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Field Cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nicController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer NIC',
                  hintText: 'Enter Volunteer NIC',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Field Cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Phone Number',
                  hintText: 'Enter Volunteer Phone Number',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> volunteers = {
                      'Volunteer_Name': nameController.text,
                      'Volunteer_Address': addressController.text,
                      'Volunteer_Email': emailController.text,
                      'Volunteer_Nic': nicController.text,
                      'Volunteer_Phone': phoneController.text,
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
                              dbRef.push().set(volunteers);

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
                                    builder: (context) => VolunteerHomePage()),
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
