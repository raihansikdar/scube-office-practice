import 'package:beamar_navigation_web/utils/app_routing.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: AppRouting.routerDelegate,
    );
  }
}
