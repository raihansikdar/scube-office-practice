import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
   ProductScreen({super.key});

  final GlobalKey<BeamerState> _beamerKey = GlobalKey<BeamerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('product screen'),
      automaticallyImplyLeading: false,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is product Screen'),
            ElevatedButton(onPressed: (){
              // Navigator.maybePop(context);
              // Beamer.of(context).beamBack();
              Beamer.of(context).popToNamed('/');

            }, child: const Text('back home'))
          ],
        ),
      ),
    );
  }
}
