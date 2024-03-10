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
               String productName = 'ok-product';

             // context.beamToNamed('/cart',data: {'productName':productName});
               context.beamToNamed('/cart/$productName');
            }, child: const Text('cart'),
            ),


          ],
        ),
      ),
    );
  }
}
