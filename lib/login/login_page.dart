// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_store/data_files/secure_file.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../homescreen/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final SecureStorage secureStorage = SecureStorage();
  final username = TextEditingController(text: "johnd");
  final password = TextEditingController(text: "m38rmF\$");
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
                      FocusScope.of(context).unfocus();
                      Future<void> userData(
                          String username, String password) async {
                        final response = await http.post(
                          Uri.parse('https://fakestoreapi.com/auth/login'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'username': username,
                            'password': password,
                          }),
                        );

                        if (response.statusCode == 200) {
                          secureStorage.writeSecureData('logedin', 'true');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          print(response.body);
                          snack(text: response.body);
                        }
                      }

                      setState(() {
                        logincredts = userData(username.text, password.text);
                      });
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
                space(),
                Text(
                  ' username: "johnd", password: "m38rmF\$"',
                  style: TextStyle(fontSize: 15.0),
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
