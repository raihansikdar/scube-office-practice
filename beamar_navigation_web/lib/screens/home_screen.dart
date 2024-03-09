import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              return context.beamToNamed('/product');
            }, child: const Text('product'),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              return context.beamToNamed('/cart/new-new');
            }, child: const Text('cart'),
            ),
          ],
        ),
      ),
    );
  }
}
