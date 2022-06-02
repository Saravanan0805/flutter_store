// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_store/secure_file.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final SecureStorage secureStorage = SecureStorage();
  final username = TextEditingController();
  final password = TextEditingController();
  bool hide = true;
  bool hidepass = false;
  bool pwd = false;
  Future<void>? logincredts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Flutter Store Login',
                  style: TextStyle(fontSize: 25.0),
                ),
                extraspace(),
                logfields(
                  obscure: false,
                  ltext: 'Enter username',
                  htext: '',
                  control: username,
                ),
                space(),
                logfields(
                    obscure: hide,
                    ltext: 'Enter password',
                    htext: '',
                    control: password),
                Row(
                  children: <Widget>[
                    Checkbox(
                        value: hidepass,
                        onChanged: (value) {
                          setState(() {
                            hidepass = value!;
                            if (value == true) {
                              hide = false;
                            } else {
                              hide = true;
                            }
                          });
                        }),
                    Text('Show password')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {
                      secureStorage.writeSecureData('logedin', 'true');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
                extraspace(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New user?'),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        ' Register',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox space() {
    return const SizedBox(
      height: 10.0,
    );
  }

  SizedBox extraspace() {
    return const SizedBox(
      height: 20.0,
    );
  }

  snack({required String text}) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextField logfields(
      {required String ltext,
      required String htext,
      required TextEditingController control,
      required bool obscure}) {
    return TextField(
      controller: control,
      obscureText: obscure,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ltext,
        hintText: htext,
        labelStyle: TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
        ),
      ),
    );
  }
}
