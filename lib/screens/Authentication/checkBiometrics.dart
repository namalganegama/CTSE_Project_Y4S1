import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class biomatrics extends StatefulWidget {
  @override
  State<biomatrics> createState() => _biomatricsState();
}

class _biomatricsState extends State<biomatrics> {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await localAuth.canCheckBiometrics;
    } catch (e) {
      print("Error checking for biometrics: $e");
      canCheckBiometrics = false;
    }
    if (!canCheckBiometrics) {
      print("Biometrics not available on this device.");
    }
  }

  Future<void> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
      );
    } catch (e) {
      print("Error during authentication: $e");
    }

    if (isAuthenticated) {
      print("Authentication successful");
    } else {
      print("Authentication failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Biometric Authentication'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: checkBiometrics,
                child: Text('Check Biometrics Availability'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: authenticate,
                child: Text('Authenticate with Biometrics'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
