import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/data_files/splash_screen.dart';
import 'package:flutter_store/userAccount/account_page.dart';
import 'homescreen/homepage.dart';

void main() {
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
