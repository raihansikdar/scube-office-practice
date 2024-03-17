


/*
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:beamer/beamer.dart';

// DATA
class Book {
  const Book(this.id, this.title, this.author);

  final int id;
  final String title;
  final String author;
}

const List<Book> books = [
  Book(1, 'Stranger in a Strange Land', 'Robert A. Heinlein'),
  Book(2, 'Foundation', 'Isaac Asimov'),
  Book(3, 'Fahrenheit 451', 'Ray Bradbury'),
];

// SCREENS
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.beamToNamed('/books'),
          child: const Text('See books'),
        ),
      ),
    );
  }
}

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView(
        children: books
            .map(
              (book) => ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () => context.beamToNamed('/books/${book.id}'),
          ),
        )
            .toList(),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  final Book? book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? 'Not Found'),
      ),
      body: book != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: ${book!.author}'),
      )
          : const SizedBox.shrink(),
    );
  }
}

// LOCATIONS
class BooksLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/books/:bookId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: HomeScreen(),
      ),
      if (state.uri.pathSegments.contains('books'))
        const BeamPage(
          key: ValueKey('books'),
          title: 'Books',
          child: BooksScreen(),
        ),
    ];
    final String? bookIdParameter = state.pathParameters['bookId'];
    if (bookIdParameter != null) {
      final bookId = int.tryParse(bookIdParameter);
      final book = books.firstWhereOrNull((book) => book.id == bookId);
      pages.add(
        BeamPage(
          key: ValueKey('book-$bookIdParameter'),
          title: 'Book #$bookIdParameter',
          child: BookDetailsScreen(book: book),
        ),
      );
    }
    return pages;
  }
}

// APP
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [BooksLocation()],
    ),
    notFoundRedirectNamed: '/books',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
      BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

void main() => runApp(MyApp());*/
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        CartLocation(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}

class HomeLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('home'),
        child: HomeScreen(),
      ),
    ];
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.beamToNamed('/cart/ok-product');
          },
          child: const Text('Go to cart'),
        ),
      ),
    );
  }
}

class CartLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/cart/:productName'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final productName = state.pathParameters['productName']!;
    return [
      BeamPage(
        key: ValueKey('cart-$productName'),
        child: CartScreen(productName: productName),
      ),
    ];
  }
}

class CartScreen extends StatelessWidget {
  final String productName;

  CartScreen({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Cart'),
      ),
      body: Center(
        child: Text('Product Name: $productName'),
      ),
    );
  }
}
