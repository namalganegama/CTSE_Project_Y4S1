import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Volunteer/fetch_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/Authentication/home_page.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.volunteerKey}) : super(key: key);

  final String volunteerKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
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
    getVolunteerData();
  }

  void getVolunteerData() async {
    DataSnapshot snapshot = await dbRef.child(widget.volunteerKey).get();

    Map item = snapshot.value as Map;

    nameController.text = item['Volunteer_Name'];
    addressController.text = item['Volunteer_Address'];
    emailController.text = item['Volunteer_Email'];
    nicController.text = item['Volunteer_Nic'];
    phoneController.text = item['Volunteer_Phone'];
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Update Volunteer Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Name',
                  hintText: 'Enter Volunteer Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Address',
                  hintText: 'Enter Volunteer Address',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer Email',
                  hintText: 'Enter Volunteer Email',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nicController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Volunteer NIC',
                  hintText: 'Enter Volunteer NIC',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
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
                            dbRef.child(widget.volunteerKey).update(volunteers);

                            Fluttertoast.showToast(
                              msg: "Data Updated Successfully!",
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
                                  builder: (context) => FetchData()),
                            );
                          },
                          child: Text('Yes'),
                        ),
                      ],
                      title: const Text('Alert'),
                      contentPadding: const EdgeInsets.all(20.0),
                      content: const Text('Do You Want To Update Data ?'),
                    ),
                  );
                },
                child: const Text('Update Data'),
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
