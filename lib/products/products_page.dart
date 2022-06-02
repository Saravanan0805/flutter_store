import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/homescreen/db_class.dart';

class ProductsPage extends StatefulWidget {
  final StoreList productDetails;
  const ProductsPage({Key? key, required this.productDetails})
      : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    double height = window.physicalSize.height / window.devicePixelRatio;
    double width = window.physicalSize.width / window.devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productDetails.title),
        centerTitle: true,
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.transparent,
              width: width * 0.45,
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {},
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: width * 0.45,
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {},
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ),
          ],
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.4,
                  color: Colors.transparent,
                  child: Image.network(
                    widget.productDetails.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('reload'),
                      );
                    },
                  ),
                ),
              ),
              extraspace(),
              Text(
                widget.productDetails.title,
                style: const TextStyle(fontSize: 17.0),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: widget.productDetails.rating.rate.toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                  Text(
                      '${widget.productDetails.rating.count.toString()} ratings')
                ],
              ),
              space(),
              Text(
                '₹ ${widget.productDetails.price.toString()}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              space(),
              const Text(
                'Description',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              space(),
              Text(widget.productDetails.description)
            ],
          ),
        ),
      ),
    );
  }
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
