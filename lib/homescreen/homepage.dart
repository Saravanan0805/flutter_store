import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/cart/cartPage.dart';
import 'package:flutter_store/homescreen/db_class.dart';
import 'package:flutter_store/homescreen/db_method.dart';
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
  Future<List<StoreList>>? getData;
  List<dynamic> categories = [''];
  String? social;
  String url = 'https://fakestoreapi.com/products';
  Color bgColor = Colors.blue;
  int? indexNo;
  List<StoreList>? products;
  @override
  void initState() {
    categoryListDB();

    super.initState();
  }

  Future<dynamic> categoryListDB() async {
    http.Response response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    setState(() {
      categories = json.decode(response.body);
    });
    print(categories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawermenu(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Fultter store'),
        //elevation: 0,
        //  backgroundColor: Colors.white,
        //iconTheme: const IconThemeData(color: Colors.green),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart(productsList: products!)));
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
                            childAspectRatio: 3 / 4,
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
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Container(
                                            color: Colors.transparent,
                                            height: 150,
                                            width: 150,
                                            child: Image.network(products.image,
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
                                            }),
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ),
                                        ],
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
}
