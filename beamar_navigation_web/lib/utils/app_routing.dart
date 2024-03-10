// import 'package:beamar_navigation_web/screens/cart_screen.dart';
// import 'package:beamar_navigation_web/screens/home_screen.dart';
// import 'package:beamar_navigation_web/screens/products_screen.dart';
// import 'package:beamar_navigation_web/utils/locations.dart';
// import 'package:beamer/beamer.dart';
//
// class AppRouting{
//   static final routerDelegate = BeamerDelegate(
//  /*   locationBuilder: RoutesLocationBuilder(
//       routes: {
//         '/': (context, state, data) => const HomeScreen(),
//         '/product': (context, state, data) => const ProductScreen(),
//         '/cart/:productName': (context, state, data) {
//           final productName = state.pathParameters['productName']!;
//           //return CartScreen(productName: productName,);
//           return BeamPage(
//             //key: ValueKey('book-$bookId'),
//            // title: 'A Book #$bookId',
//             popToNamed: '/',
//             type: BeamPageType.scaleTransition,
//             child: CartScreen(productName: productName,),
//           );
//         }
//       },
//     ).call,*/
//     locationBuilder: BeamerLocationBuilder(
//       beamLocations: [HomeLocation(), ProductLocation(), CartLocation()],
//     ).call,
//
//   );
// }

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';
import '../screens/products_screen.dart';
import 'locations.dart';

class AppRouting {
  static final routerDelegate = BeamerDelegate(
    locationBuilder: (routeInformation, _) {
      if (routeInformation.uri.pathSegments.contains('product')) {
        return ProductLocation();
      }
      if (routeInformation.uri.pathSegments.contains('cart')) {
        return CartLocation();
      }
      return HomeLocation();
    },
  );
}
