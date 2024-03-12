import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load_json_data_to_grid/binding/state_holders_binders.dart';
import 'package:load_json_data_to_grid/views/home_screen.dart';

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



