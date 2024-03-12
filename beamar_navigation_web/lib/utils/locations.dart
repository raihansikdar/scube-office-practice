import 'package:beamar_navigation_web/screens/cart_screen.dart';
import 'package:beamar_navigation_web/screens/home_screen.dart';
import 'package:beamar_navigation_web/screens/products_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
            key: ValueKey('home'), title: 'Home', child: HomeScreen())
      ];

  @override
  List<Pattern> get pathPatterns => ["/"];
}

class ProductLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: const ValueKey('product'),
          title: 'Product',
          child: ProductScreen()),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/product'];
}



class CartLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathBlueprints => ['/cart/:productName'];

  @override
  List<Pattern> get pathPatterns {
    return ['/cart/:productName'];
  }
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final productName = state.pathParameters[pathBlueprints];
    print("===>productName: $productName");

    if (productName != null) {
      return [
        BeamPage(
          key: const ValueKey('cart'),
          title: 'Cart',
          child: CartScreen(productName: productName),
        ),
      ];
    }

    // Handle the case where productName is null by showing a default message.
    return [
      BeamPage(
        key: const ValueKey('cart'),
        title: 'Cart',
        child: CartScreen(productName: 'Product Name is Null'),
      ),
    ];
  }


}




