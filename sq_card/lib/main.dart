import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double todayGenerationValue = 0;
   double yesterdayGenerationValue = 0;
   double moduleTempValue = 0;
   double ambientTempValue = 0;
   double radiationEastValue = 0;
   double radiationWestValue = 0;
   double radiationNorthValue = 0;
   double radiationSouthValue = 0;
   double radiationSouth15Value = 0;
   double grossProfitValue = 0;

Future<void>fetchData()async{
  const String _baseUrl = 'http://192.168.60.60:8000/';
  const String authToken = '';

  String todayGenerationEndPoint = '/single-today-generation/';
  String yesterdayGenerationEndPoint = '/single-yesterday-generation/';
  String tempAndRadiationEndPoint = '/single-radiation/';
  String grossProfitEndPoint = '/single-gross-profit/';


  final todayGenerationResponse = await http.get(Uri.parse(_baseUrl + todayGenerationEndPoint), headers: {'Authorization': authToken});
  final yesterdayGenerationResponse = await http.get(Uri.parse(_baseUrl + yesterdayGenerationEndPoint), headers: {'Authorization': authToken});
  final tempAndRadiationResponse = await http.get(Uri.parse(_baseUrl + tempAndRadiationEndPoint), headers: {'Authorization': authToken});
  final grossProfitResponse = await http.get(Uri.parse(_baseUrl + grossProfitEndPoint), headers: {'Authorization': authToken});



  if(todayGenerationResponse.statusCode == 200 && yesterdayGenerationResponse.statusCode == 200 && tempAndRadiationResponse.statusCode ==200 && grossProfitResponse.statusCode==200){
     final todayGenerationJsonData = jsonDecode(todayGenerationResponse.body);
     final yesterdayGenerationJsonData = jsonDecode(yesterdayGenerationResponse.body);
     final tempAndRadiationJsonData = jsonDecode(tempAndRadiationResponse.body);
     final grossProfitJsonData = jsonDecode(grossProfitResponse.body);


     setState(() {
       todayGenerationValue = todayGenerationJsonData['plant'];
       yesterdayGenerationValue = yesterdayGenerationJsonData['plant'];
       moduleTempValue =tempAndRadiationJsonData['module_temp'];
       ambientTempValue =tempAndRadiationJsonData['ambient_temp'];
       radiationEastValue =tempAndRadiationJsonData['radiation_east'];
       radiationWestValue =tempAndRadiationJsonData['radiation_west'];
       radiationNorthValue =tempAndRadiationJsonData['radiation_north'];
       radiationSouthValue =tempAndRadiationJsonData['radiation_south'];
       radiationSouth15Value =tempAndRadiationJsonData['radiation_south_15'];
       grossProfitValue = grossProfitJsonData['energy_cost'];

     });
  }else {
    throw Exception('Failed to load data');
  }
}

@override
  void initState() {
   fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----------- Generation-------
              SizedBox(
                height: 200,
                width: 300,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 2.0,
                  child: Column(

                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Generation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: Center(
                         child: Column(
                           //crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Center(
                               child: Text.rich(
                                 textAlign: TextAlign.center,
                                 TextSpan(
                                   children: [
                                     const TextSpan(text: "Today's Net : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                     TextSpan(
                                       text: todayGenerationValue.toStringAsFixed(2),
                                       style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             const SizedBox(height: 8.0,),
                              Text.rich(
                               TextSpan(
                                 children: [
                                   const TextSpan(text: "Yesterday's Net : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                   TextSpan(
                                     text: yesterdayGenerationValue.toStringAsFixed(2),
                                     style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     )
                    ],
                  ),
                ),
              ),
              //----------- Temperature-------
              SizedBox(
                height: 200,
                width: 300,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 2.0,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Temperature',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "Module Temperature : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${moduleTempValue.toStringAsFixed(0) }°C",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "30 min Average : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${ambientTempValue.toStringAsFixed(0) }°C",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //----------- Radiation-------
              SizedBox(
                height: 200,
                width: 300,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 2.0,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Radiation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "East : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${radiationEastValue.toStringAsFixed(0)} W/m²",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "West : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${radiationWestValue.toStringAsFixed(0)} W/m²",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "North : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${radiationNorthValue.toStringAsFixed(0)} W/m²",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "South : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${radiationSouthValue.toStringAsFixed(0)} W/m²",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "South 15°C : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${radiationSouth15Value.toStringAsFixed(0)} W/m²",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //----------- Gross Profit-------
              SizedBox(
                height: 200,
                width: 300,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 2.0,
                  child: Column(

                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Gross Profit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      const TextSpan(text: "Gross Profit : ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                      TextSpan(
                                        text: "${grossProfitValue.toStringAsFixed(2)} ৳",
                                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PowerModel{
  final double todayGeneration;
  final double yesterdayGeneration;
  final double moduleTemp;
  final double ambientTemp;
  final double radiationEast;
  final double radiationWest;
  final double radiationNorth;
  final double radiationSouth;
  final double radiationSouth15;
  final double energyCost;

  PowerModel({required this.todayGeneration, required this.yesterdayGeneration, required this.moduleTemp, required this.ambientTemp, required this.radiationEast, required this.radiationWest, required this.radiationNorth, required this.radiationSouth, required this.radiationSouth15, required this.energyCost});

  factory PowerModel.fromJson(Map<String,dynamic>json){
    return PowerModel(
      todayGeneration: json['plant'],
      yesterdayGeneration: json['plant'],
      moduleTemp: json['module_temp'],
      ambientTemp: json['ambient_temp'],
      radiationEast: json['radiation_east'],
      radiationWest: json['radiation_west'],
      radiationNorth: json['radiation_north'],
      radiationSouth: json['radiation_south'],
      radiationSouth15: json['radiation_south_15'],
      energyCost: json['energy_cost'],
    );
  }
}
