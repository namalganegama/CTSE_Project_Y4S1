import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class jailBreak extends StatefulWidget {
  @override
  State<jailBreak> createState() => _jailBreakState();
}

class _jailBreakState extends State<jailBreak> {
  bool isJailbroken = false;

  @override
  void initState() {
    super.initState();
    checkJailbreakStatus();
  }

  Future<void> checkJailbreakStatus() async {
    try {
      final jailbreakStatus = await FlutterJailbreakDetection.jailbroken;
      setState(() {
        isJailbroken = jailbreakStatus;
      });
    } catch (e) {
      print("Error checking jailbreak status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jailbreak Detection'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                isJailbroken
                    ? 'This device is jailbroken/rooted.'
                    : 'This device is not jailbroken/rooted.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
