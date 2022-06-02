import 'dart:math';

import 'package:flutter/material.dart';
import 'db_method_account.dart';
import 'db_class_account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  HttpService httpService = HttpService();
  String url = 'https://fakestoreapi.com/users/1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: httpService.getUserDetails(url),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserDetails>> snapshot) {
                if (snapshot.hasData) {
                  List<UserDetails>? userData = snapshot.data;
                  return ListView(
                      children: userData!
                          .map(
                            (UserDetails userData) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.primaries[
                                            Random().nextInt(
                                                Colors.primaries.length)],
                                        child: Center(
                                          child: Text(
                                            userData.name.firstname
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    myaccount(
                                      lead: Icons.people,
                                      sub: userData.username,
                                      title: 'Full Name / Business Name',
                                      ontap: () {},
                                    ),
                                    myaccount(
                                      lead: Icons.people,
                                      sub: userData.phone,
                                      title: 'Mobile',
                                      ontap: () {},
                                    ),
                                    myaccount(
                                      lead: Icons.email,
                                      sub: userData.email,
                                      title: 'Email ID',
                                      ontap: () {},
                                    ),
                                    myaccount(
                                      lead: Icons.location_on,
                                      sub: userData.address.street,
                                      title: 'street',
                                      ontap: () {},
                                    ),
                                    myaccount(
                                      lead: Icons.location_city,
                                      sub: userData.address.city,
                                      title: 'city',
                                      ontap: () {},
                                    ),
                                    myaccount(
                                      lead: Icons.location_on,
                                      sub: userData.address.zipcode,
                                      title: 'Zipcode',
                                      ontap: () {},
                                    ),
                                  ],
                                )),
                          )
                          .toList());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  ListTile myaccount(
      {required String title,
      required String sub,
      required void Function()? ontap,
      required IconData lead}) {
    return ListTile(
      leading: Icon(lead),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black54),
      ),
      subtitle: Text(
        sub,
        style: TextStyle(fontSize: 15.0, color: Colors.black87),
      ),
      trailing: Icon(Icons.edit),
      onTap: ontap,
    );
  }
}
