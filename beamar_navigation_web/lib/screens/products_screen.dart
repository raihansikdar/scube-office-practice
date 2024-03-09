import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('product screen'),
      automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('This is product Screen')),
    );
  }
}
