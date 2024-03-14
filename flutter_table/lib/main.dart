import 'package:flutter/material.dart';
import 'package:flutter_table/bindings/state_holders_binder.dart';
import 'package:flutter_table/data_table_screen.dart';
import 'package:flutter_table/views/home_screen.dart';
import 'package:flutter_table/table_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StateHoldersBinders(),
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}


