import 'package:flutter/material.dart';
import 'package:project/screens/Donation/insert_data.dart';
import 'package:project/screens/Donation/fetch_data.dart';
import 'package:project/screens/Authentication/home_page.dart';
import 'package:project/screens/Authentication/encryption.dart';

class DonationHomePage extends StatefulWidget {
  const DonationHomePage({Key? key}) : super(key: key);

  @override
  State<DonationHomePage> createState() => _DonationHomePageState();
}

class _DonationHomePageState extends State<DonationHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Donation Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            const Image(
              width: 300,
              height: 300,
              image: NetworkImage(
                  'https://i0.wp.com/ketto.blog/wp-content/uploads/2020/10/shutterstock_1735703225-e1603424756464.jpg?fit=547%2C292&ssl=1'),
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InsertDonationData()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Insert Donation Details'),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FetchDonationData()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('View Donation Details'),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => encryption()));
              },
              color: Colors.red,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Encryption'),
            ),
          ],
        ),
      ),
    );
  }
}
