// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

Drawer drawermenu({
  // required String username,
  required void Function()? myaccount,
  //required void Function()? mycampaign,
  // required void Function()? mywallet,
  //required void Function()? privacy,
  //required void Function()? help,
  required void Function()? logout,
}) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  extraspace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'Flutter store',
                        style: TextStyle(fontSize: 25.0),
                      )
                    ],
                  ),
                  extraspace(),
                  Divider(
                    color: Colors.indigo,
                  ),
                  menutiles(
                    ontap: myaccount,
                    lead: Icons.account_circle_sharp,
                    title: 'My Accounts',
                  ),
                  menutiles(
                    // ontap: mywallet,
                    lead: Icons.account_balance_wallet_rounded,
                    title: 'My Orders',
                  ),
                  menutiles(ontap: logout, lead: Icons.info, title: ' Log Out'),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

InkWell menutiles(
    {required String title, required IconData lead, void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    splashColor: Colors.indigo,
    child: ListTile(
      leading: Icon(lead, color: Colors.amber.shade700),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.indigo, fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
      //trailing: Icon(Icons.arrow_forward, color: Colors.amber.shade700),
    ),
  );
}

SizedBox extraspace() {
  return SizedBox(
    height: 20.0,
  );
}
