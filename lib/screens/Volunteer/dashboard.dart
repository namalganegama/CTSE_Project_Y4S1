import 'package:flutter/material.dart';
import 'package:project/screens/Volunteer/insert_data.dart';
import 'package:project/screens/Volunteer/fetch_data.dart';
import 'package:project/screens/Authentication/home_page.dart';

class VolunteerHomePage extends StatefulWidget {
  const VolunteerHomePage({Key? key}) : super(key: key);

  @override
  State<VolunteerHomePage> createState() => _VolunteerHomePageState();
}

class _VolunteerHomePageState extends State<VolunteerHomePage> {
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
              'Volunteer Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
            const Image(
              width: 300,
              height: 300,
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/people-volunteering-donating-money_53876-66112.jpg'),
              // AssetImage('dash/volunteer.jpg'),
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InsertData()));
              },
              child: const Text('Insert Volunteer Details'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FetchData()));
              },
              child: const Text('View Volunteer Details'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
