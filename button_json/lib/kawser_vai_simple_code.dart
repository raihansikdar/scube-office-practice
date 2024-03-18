import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  isOn = !isOn;
                });
              },
              child: Text(isOn ? 'On' : 'Off'),
            ),
          )
        ],
        title: const Text('New Page'),
      ),
      body: Column(

        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(isOn: isOn)),
              );
            },
            child: const Text('Go to Second Page'),
          ),
          Text("Switch Is ${isOn ? 'On' : 'Off'}")
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final bool isOn;

  const SecondPage({Key? key, required this.isOn}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late double totalRebEnergy = 0; // Initialize to a default value .// 0 error handle kore dische

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url = Uri.parse('https://scubetech.xyz/kazi-habibpur/total-reb-energy/');
    final headers = {
      'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        totalRebEnergy = widget.isOn ? data['total_reb_energy_absolute'] : data['total_reb_energy'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Text('Total REB Energy: ${totalRebEnergy.toStringAsFixed(2) }'),
      ),
    );
  }
}