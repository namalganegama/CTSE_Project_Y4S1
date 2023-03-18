import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Donation/fetch_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/Authentication/home_page.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.donationKey}) : super(key: key);

  final String donationKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final itemNameController = TextEditingController();
  final itemTypeController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Donations');
    getDonationData();
  }

  void getDonationData() async {
    DataSnapshot snapshot = await dbRef.child(widget.donationKey).get();

    Map donation = snapshot.value as Map;

    itemNameController.text = donation['Item_Name'];
    itemTypeController.text = donation['Item_Type'];
    dateController.text = donation['Date'];
    amountController.text = donation['Amount'];
    descriptionController.text = donation['Description'];
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
                'Update Donation Details',
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
                controller: itemNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                  hintText: 'Enter Item Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: itemTypeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Type',
                  hintText: 'Enter Item Type',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Donation Date',
                  hintText: 'Enter Donation Date',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Amount',
                  hintText: 'Enter Item Amount',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Description',
                  hintText: 'Enter Item Description',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> donations = {
                    'Item_Name': itemNameController.text,
                    'Item_Type': itemTypeController.text,
                    'Date': dateController.text,
                    'Amount': amountController.text,
                    'Description': descriptionController.text
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
                            dbRef.child(widget.donationKey).update(donations);

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

                  // dbRef
                  //     .child(widget.donationKey)
                  //     .update(donations)
                  //     .then((value) => {Navigator.pop(context)});
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
