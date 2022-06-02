import 'dart:async';
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
  String picUrl = "https://randomuser.me/api/portraits/men/0.jpg";
  List<UserDetails>? userData;
  @override
  void initState() {
    randomProfilegenerator();
    super.initState();
  }

  void randomProfilegenerator() {
    int no = Random().nextInt(90);

    setState(() {
      picUrl = "https://randomuser.me/api/portraits/men/$no.jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
              future: httpService.getUserDetails(url),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserDetails>> snapshot) {
                if (snapshot.hasData) {
                  userData = snapshot.data;
                  return ListView(
                      children: userData!
                          .map(
                            (UserDetails userData) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    extraspace(),
                                    extraspace(),
                                    extraspace(),
                                    CircleAvatar(
                                      radius: 35,
                                      child: ClipOval(
                                        child: Center(
                                          child: Image.network(
                                            picUrl,
                                            fit: BoxFit.contain,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Text('reload'),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    extraspace(),
                                    myaccount(
                                      lead: Icons.people,
                                      sub: userData.username,
                                      title: 'Full Name / Business Name',
                                      ontap: () {},
                                    ),
                                    space(),
                                    myaccount(
                                      lead: Icons.people,
                                      sub: userData.phone,
                                      title: 'Mobile',
                                      ontap: () {},
                                    ),
                                    space(),
                                    myaccount(
                                      lead: Icons.email,
                                      sub: userData.email,
                                      title: 'Email ID',
                                      ontap: () {},
                                    ),
                                    extraspace(),
                                    ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: const Text(
                                        'Address',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'No. ${userData.address.number},${userData.address.street} street,',
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                          ),
                                          Text(
                                            '${userData.address.city}  - ${userData.address.zipcode}',
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
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
        style: const TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black54),
      ),
      subtitle: Text(
        sub,
        style: const TextStyle(fontSize: 15.0, color: Colors.black87),
      ),
      trailing: const Icon(Icons.edit),
      onTap: ontap,
    );
  }

  SizedBox extraspace() {
    return const SizedBox(
      height: 20.0,
    );
  }

  SizedBox space() {
    return const SizedBox(
      height: 10.0,
    );
  }
}
