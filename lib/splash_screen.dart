// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_store/homescreen/homepage.dart';
import 'package:flutter_store/login_page.dart';
import 'package:flutter_store/secure_file.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? logedIn;

  final SecureStorage secureStorage = SecureStorage();
  Future<void>? getFollowersdb;
  @override
  void initState() {
    super.initState();
    hasNetwork();
  }

  Future<void> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return initApp();
      }
    } on SocketException catch (_) {
      return alert();
    }
  }

  initApp() async {
    Timer(Duration(seconds: 2), () async {
      await secureStorage.readSecureData('logedin').then((value) {
        if (value == 'true') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
    });
  }

  @override
  void dispose() {
    SplashScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Text(
            'Flutter Store',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future alert() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Text(
                'You\'re offline, check your connectivity and try again',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'),
                )
              ],
            );
          },
        );
      },
    );
  }
}
