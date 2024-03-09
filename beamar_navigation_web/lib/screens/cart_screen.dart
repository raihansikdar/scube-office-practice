import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final String productName;

   const CartScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Cart Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Product Name: $productName'),
      ),
    );
  }
}