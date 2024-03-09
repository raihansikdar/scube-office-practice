import 'package:beamar_navigation_web/screens/cart_screen.dart';
import 'package:beamar_navigation_web/screens/home_screen.dart';
import 'package:beamar_navigation_web/screens/products_screen.dart';
import 'package:beamer/beamer.dart';

class AppRouting{
  static final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomeScreen(),
        '/product': (context, state, data) => const ProductScreen(),
        '/cart/:productName': (context, state, data) {
          final productName = state.pathParameters['productName']!;
          return CartScreen(productName: productName,);
        }
      },
    ).call,
  );
}