import 'package:flutter/material.dart';
import 'package:project/screens/Beneficary/insert_data.dart';
import 'package:project/screens/Beneficary/fetch_data.dart';
import 'package:project/screens/Authentication/home_page.dart';

class BeneficaryHomePage extends StatefulWidget {
  const BeneficaryHomePage({Key? key}) : super(key: key);

  @override
  State<BeneficaryHomePage> createState() => _BeneficaryHomePageState();
}

class _BeneficaryHomePageState extends State<BeneficaryHomePage> {
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
              'Beneficary Dashboard',
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
                  'https://healthpayerintelligence.com/images/site/article_headers/_normal/GettyImages-1205508943.png'),
              // AssetImage('dash/beneficary.jpg'),
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
              child: const Text('Insert Beneficary Details'),
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
              child: const Text('View Beneficary Details'),
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
