import 'package:beamar_navigation_web/screens/cart_screen.dart';
import 'package:beamar_navigation_web/screens/home_screen.dart';
import 'package:beamar_navigation_web/screens/products_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeLocation extends BeamLocation<BeamState>{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) =>[
    const BeamPage(
        title: 'Home',
        child: HomeScreen())
  ];

  @override
  // TODO: implement pathPatterns
  List<Pattern> get pathPatterns => ["/*"];

}

class ProductLocation extends BeamLocation<BeamState>{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          title: 'Product',
          child: ProductScreen()),
    ];
  }

  @override
  // TODO: implement pathPatterns
  List<Pattern> get pathPatterns => ["/product"];

}




class CartLocation extends BeamLocation<BeamState>{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
          title: 'Cart',
          child: CartScreen(productName: 'new-new',)),
    ];
  }

  @override
  // TODO: implement pathPatterns
  List<Pattern> get pathPatterns => ["/cart"];

}

