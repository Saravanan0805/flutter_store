import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/cart/cartPage.dart';
import 'package:flutter_store/homescreen/db_class.dart';
import 'package:flutter_store/homescreen/db_method.dart';
import 'package:flutter_store/login/login_page.dart';
import 'package:flutter_store/data_files/secure_file.dart';
import 'package:flutter_store/products/products_page.dart';
import 'package:flutter_store/userAccount/account_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'darwer_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();
  List<dynamic> categories = [''];
  String url = 'https://fakestoreapi.com/products';
  Color bgColor = Colors.blue;
  int? indexNo;
  List<StoreList>? products;
  List<StoreList>? value;
  final SecureStorage secureStorage = SecureStorage();
  int loadingTimer = 0;
  @override
  void initState() {
    categoryListDB();
    timer();
    super.initState();
  }

  Future<dynamic> categoryListDB() async {
    http.Response response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    setState(() {
      categories = json.decode(response.body);
    });
  }

  void timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (value != null) {
        timer.cancel();
        ScaffoldMessenger.of(context).clearSnackBars();
      } else {
        snack(text: 'Please wait');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawermenu(myaccount: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountPage()));
      }, logout: () {
        secureStorage.deleteSecureData('logedin');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      }),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Fultter store'),
        //elevation: 0,
        //  backgroundColor: Colors.white,
        //iconTheme: const IconThemeData(color: Colors.green),
        actions: [
          IconButton(
              onPressed: () {
                value != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cart(productsList: value!)))
                    : snack(text: "wait till loading complete's..");
              },
              icon: const Icon(Icons.shopping_bag_rounded))
        ],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FutureBuilder(
              future: httpService.getProducts(url),
              builder: (BuildContext context,
                  AsyncSnapshot<List<StoreList>> snapshot) {
                if (snapshot.hasData) {
                  if (value == null) {
                    value = snapshot.data;
                  } else {
                    value = value;
                  }

                  products = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 45,
                          // width: 180,
                          child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (indexNo != i) {
                                          indexNo = i;
                                          url =
                                              'https://fakestoreapi.com/products/category/${categories[i]}';
                                        } else {
                                          indexNo = null;
                                          url =
                                              'https://fakestoreapi.com/products';
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      height: 20,
                                      child: Text(
                                        categories[i],
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.transparent,
                                      backgroundColor: indexNo == i
                                          ? bgColor
                                          : Colors.transparent,
                                      side: const BorderSide(
                                          width: 0.8, color: Colors.indigo),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  ));
                            },
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Deals of the day',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Scrollbar(
                          child: GridView.count(
                            childAspectRatio: 3.2 / 4.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            children: products!
                                .map(
                                  (StoreList products) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(0, 1),
                                              blurRadius: 3.0,
                                              spreadRadius: 1.0)
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsPage(
                                                          productDetails:
                                                              products)));
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Container(
                                              color: Colors.transparent,
                                              height: 150,
                                              width: 150,
                                              child: Image.network(
                                                products.image,
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
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Center(
                                                    child: Text('reload'),
                                                  );
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    products.category,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    products.title.length > 30
                                                        ? products.title
                                                            .substring(0, 30)
                                                        : products.title,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Text(
                                                  '₹ ${products.price.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('no data'),
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

  snack({required String text}) {
    final snackBar = SnackBar(
      duration: const Duration(minutes: 10),
      content: Text(text),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
