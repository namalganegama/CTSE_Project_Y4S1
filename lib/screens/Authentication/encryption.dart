import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';

class encryption extends StatefulWidget {
  @override
  State<encryption> createState() => _encryptionState();
}

class _encryptionState extends State<encryption> {
  @override
  Widget build(BuildContext context) {
    final key = encrypt.Key.fromUtf8('ASDFGHJKLASDFGHJ');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    String plainText = 'This is a secret message';
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    String encryptedText = encrypted.base64;

    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Encrypt'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Original Text: $plainText',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Encrypted Text: $encryptedText',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Decrypted Text: $decrypted',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
