import 'package:beamar_navigation_web/screens/cart_screen.dart';
import 'package:beamar_navigation_web/screens/home_screen.dart';
import 'package:beamar_navigation_web/screens/products_screen.dart';
import 'package:beamar_navigation_web/utils/locations.dart';
import 'package:beamer/beamer.dart';

class AppRouting{
  static final routerDelegate = BeamerDelegate(
 /*   locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomeScreen(),
        '/product': (context, state, data) => const ProductScreen(),
        '/cart/:productName': (context, state, data) {
          final productName = state.pathParameters['productName']!;
          //return CartScreen(productName: productName,);
          return BeamPage(
            //key: ValueKey('book-$bookId'),
           // title: 'A Book #$bookId',
            popToNamed: '/',
            type: BeamPageType.scaleTransition,
            child: CartScreen(productName: productName,),
          );
        }
      },
    ).call,*/
    locationBuilder: (routeInformation, _) {
      if (routeInformation.uri.contains('/product')) {

        return ProductScreen();
      }
      if(routeInformation.uri == Uri.parse("/cart")){
        return CartScreen(productName: productName)
      }
          return HomeLocation();
    },

  );
}