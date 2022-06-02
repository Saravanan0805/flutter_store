import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_store/cart/db_class_cart.dart';
import 'package:flutter_store/homescreen/db_class.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'db_method_cart.dart';

class Cart extends StatefulWidget {
  final List<StoreList> productsList;
  const Cart({Key? key, required this.productsList}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String url = 'https://fakestoreapi.com/carts/1';
  HttpService httpService = HttpService();
  Future<dynamic>? products;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = window.physicalSize.height / window.devicePixelRatio;
    double width = window.physicalSize.width / window.devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Cart'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: httpService.getCart(url),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CartProducts>> snapshot) {
                if (snapshot.hasData) {
                  List<CartProducts>? products = snapshot.data;
                  return ListView(
                      children: products!
                          .map((CartProducts products) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Container(
                                color: Colors.transparent,
                                width: width * 0.95,
                                height: 150,
                                child: Center(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(
                                                widget
                                                    .productsList[(products
                                                            .productsId
                                                            .toInt() -
                                                        1)]
                                                    .image,
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
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              color: Colors.transparent,
                                              width: width * 0.5,
                                              child: Text(
                                                widget
                                                    .productsList[(products
                                                            .productsId
                                                            .toInt() -
                                                        1)]
                                                    .title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            space(),
                                            Container(
                                              color: Colors.transparent,
                                              width: 200,
                                              child: Text(
                                                widget
                                                            .productsList[(products
                                                                    .productsId
                                                                    .toInt() -
                                                                1)]
                                                            .description
                                                            .length >
                                                        100
                                                    ? '${widget.productsList[(products.productsId.toInt() - 1)].description.substring(0, 96)} ....'
                                                    : widget
                                                        .productsList[(products
                                                                .productsId
                                                                .toInt() -
                                                            1)]
                                                        .description,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '₹ ${widget.productsList[(products.productsId.toInt() - 1)].price.toString()}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              space(),
                                              Container(
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.remove,
                                                          size: 14,
                                                        ),
                                                      ),
                                                      Text(products.quantity
                                                          .toString()),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 14,
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )

                              /*Container(
                                  height: 100,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(widget
                                          .productsList[
                                              (products.productsId.toInt() - 1)]
                                          .title),
                                      leading: Container(
                                        color: Colors.transparent,
                                        height: 50,
                                        width: 50,
                                        child: Image.network(
                                            widget
                                                .productsList[(products
                                                        .productsId
                                                        .toInt() -
                                                    1)]
                                                .image,
                                            fit: BoxFit.contain, loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
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
                                    ),
                                  ),
                                ),*/

                              ))
                          .toList());
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

SizedBox space() {
  return const SizedBox(
    height: 8.0,
  );
}
