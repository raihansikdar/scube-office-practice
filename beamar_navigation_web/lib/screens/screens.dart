// import 'package:beamer/beamer.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/locations.dart';
//
// class MenuButton extends StatefulWidget {
//   const MenuButton({super.key,
//     required this.beamer,
//     required this.uri,
//     required this.child,
//   });
//
//   final GlobalKey<BeamerState> beamer;
//   final String uri;
//   final Widget child;
//
//   @override
//   _MenuButtonState createState() => _MenuButtonState();
// }
//
// class _MenuButtonState extends State<MenuButton> {
//   void _setStateListener() => setState(() {});
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => widget
//         .beamer.currentState?.routerDelegate
//         .addListener(_setStateListener));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final path = (context.currentBeamLocation.state as BeamState).uri.path;
//
//     return ElevatedButton(
//       onPressed: () =>
//           widget.beamer.currentState?.routerDelegate.beamToNamed(widget.uri),
//       style: ButtonStyle(
//         backgroundColor: path.contains(widget.uri)
//             ? MaterialStateProperty.all<Color>(Colors.green)
//             : MaterialStateProperty.all<Color>(Colors.blue),
//       ),
//       child: widget.child,
//     );
//   }
//
//   @override
//   void dispose() {
//     widget.beamer.currentState?.routerDelegate
//         .removeListener(_setStateListener);
//     super.dispose();
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   final _beamerKey = GlobalKey<BeamerState>();
//
//   HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Row(
//         children: [
//           Container(
//             color: Colors.blue[300],
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/books',
//                   child: const Text('Books'),
//                 ),
//                 const SizedBox(height: 16.0),
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/articles',
//                   child: const Text('Articles'),
//                 ),
//               ],
//             ),
//           ),
//           Container(width: 1, color: Colors.blue),
//           if ((context.currentBeamLocation.state as BeamState).uri.path.isEmpty)
//             Expanded(
//               child: Container(
//                 child: const Center(
//                   child: Text('Home'),
//                 ),
//               ),
//             )
//           else
//             Expanded(
//               child: ClipRRect(
//                 child: Beamer(
//                   key: _beamerKey,
//                   routerDelegate: BeamerDelegate(
//                     transitionDelegate: const NoAnimationTransitionDelegate(),
//                     locationBuilder: (routeInformation, _) =>
//                     routeInformation.location!.contains('articles')
//                         ? ArticlesLocation(routeInformation)
//                         : BooksLocation(routeInformation),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class BooksScreen extends StatelessWidget {
//   final _beamerKey = GlobalKey<BeamerState>();
//
//   BooksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Books'),
//       ),
//       body: Row(
//         children: [
//           Container(
//             color: Colors.blue[300],
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/books/authors',
//                   child: const Text('Book Authors'),
//                 ),
//                 const SizedBox(height: 16.0),
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/books/genres',
//                   child: const Text('Book Genres'),
//                 ),
//               ],
//             ),
//           ),
//           Container(width: 1, color: Colors.blue),
//           Expanded(
//             child: ClipRRect(
//               child: Beamer(
//                 key: _beamerKey,
//                 routerDelegate: BeamerDelegate(
//                   locationBuilder: (routeInformation, _) =>
//                       BooksContentLocation(routeInformation),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BooksHomeScreen extends StatelessWidget {
//   const BooksHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Books Home'),
//       ),
//     );
//   }
// }
//
// class BookAuthorsScreen extends StatelessWidget {
//   const BookAuthorsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book Authors'),
//       ),
//     );
//   }
// }
//
// class BookGenresScreen extends StatelessWidget {
//   const BookGenresScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book Genres'),
//       ),
//     );
//   }
// }
//
// class ArticlesScreen extends StatelessWidget {
//   final _beamerKey = GlobalKey<BeamerState>();
//
//   ArticlesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Articles'),
//       ),
//       body: Row(
//         children: [
//           Container(
//             color: Colors.blue[300],
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/articles/authors',
//                   child: const Text('Article Authors'),
//                 ),
//                 const SizedBox(height: 16.0),
//                 MenuButton(
//                   beamer: _beamerKey,
//                   uri: '/articles/genres',
//                   child: const Text('Article Genres'),
//                 ),
//               ],
//             ),
//           ),
//           Container(width: 1, color: Colors.blue),
//           Expanded(
//             child: ClipRRect(
//               child: Beamer(
//                 key: _beamerKey,
//                 routerDelegate: BeamerDelegate(
//                   locationBuilder: (routeInformation, _) =>
//                       ArticlesContentLocation(routeInformation),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ArticlesHomeScreen extends StatelessWidget {
//   const ArticlesHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Articles Home'),
//       ),
//     );
//   }
// }
//
// class ArticleAuthorsScreen extends StatelessWidget {
//   const ArticleAuthorsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Article Authors'),
//       ),
//     );
//   }
// }
//
// class ArticleGenresScreen extends StatelessWidget {
//   const ArticleGenresScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Article Genres'),
//       ),
//     );
//   }
// }