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

            // ElevatedButton(
            //   onPressed: () {
            //     final state = BeamState(
            //       pathPatternSegments: ['/cart', ':productName'],
            //       pathParameters: {'productName': 'ok-product'},
            //     );
            //     context.beamToNamed('/cart', data: state);
            //   },
            //   child: const Text('cart'),
            // ),


            ElevatedButton(
              onPressed: () {
                final state = BeamState(
                  pathParameters: {'productName': 'ok-product'},
                );
                print("HomeScreen BeamState: $state");
                context.beamToNamed('/cart', data: state.pathParameters);
              },
              child: const Text('cart'),
            ),





          ],
        ),
      ),
    );
  }
}
