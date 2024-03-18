/*
import 'dart:convert';

import 'package:button_json/operation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = true;

List<RebEnergyModel> rebEnergyList = <RebEnergyModel>[];
List<YearlyTotalEnergy> yearlyEnergyList = <YearlyTotalEnergy>[];

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  Future<void>fetchData() async {
    final energyResponse = await http.get(
        Uri.parse('https://scubetech.xyz/kazi-habibpur/total-reb-energy/'),
        headers: {'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308'},
    );


    final yearlyEnergyResponse = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/yearly-total-energy/'),
      headers: {'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308'},
    );

      if(energyResponse.statusCode == 200 && yearlyEnergyResponse.statusCode == 200){
        final energyJsonData = json.decode(energyResponse.body);
        final yearlyEnergyJsonData = json.decode(yearlyEnergyResponse.body);

        print("energyResponse : $energyJsonData");
        print("yearlyEnergyJsonData : $yearlyEnergyJsonData");

        if(mounted){
          setState(() {
            rebEnergyList.add(RebEnergyModel.fromJson(energyJsonData));
            //yearlyEnergyList = yearlyEnergyJsonData.map((item) => YearlyTotalEnergy.fromJson(item)).toList();
            for (var item in yearlyEnergyJsonData) {
              yearlyEnergyList.add(YearlyTotalEnergy.fromJson(item));
            }
          });
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton(onPressed: (){
              isOn = ! isOn;
              setState(() {});
            }, child:  Text(isOn ? 'On' : 'off')),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isOn ? "Reb Energy: ${rebEnergyList.isNotEmpty ? rebEnergyList[0].totalRebEnergy : 'N/A'}" : "Power Sum: ${rebEnergyList.isNotEmpty ? rebEnergyList[0].totalPowerSum : 'N/A'}"),
            Text(isOn ? "generator_1_energy: ${yearlyEnergyList.isNotEmpty? yearlyEnergyList[0].generator1Energy : 'N/A'}" : "reb_energy: ${yearlyEnergyList.isNotEmpty ? yearlyEnergyList[0].rebEnergy : 'N/A'}"),



            const SizedBox(height: 8.0,),
              const Text('Reb 2'),
            const SizedBox(height: 16.0,),
            ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> isOn ?  OperationScreen(isOn: true, totalRebEnergy: rebEnergyList[0].totalRebEnergy,generator1Energy: yearlyEnergyList[0].generator1Energy,)
                        : OperationScreen(isOn: false,totalPowerSum:rebEnergyList[0].totalPowerSum,rebEnergy: yearlyEnergyList[0].rebEnergy,)));
            }, child: const Text('Next Operation')),
          ],
        ),
      ),
    );
  }
}

class RebEnergyModel {
  final double totalPowerSum;
  final double totalRebEnergy;

  RebEnergyModel({
    required this.totalPowerSum,
    required this.totalRebEnergy,
  });

  factory RebEnergyModel.fromJson(Map<String, dynamic> json) {
    return RebEnergyModel(
      totalPowerSum: json['total_reb_energy_absolute'],
      totalRebEnergy: json['total_reb_energy'],
    );
  }
}
class YearlyTotalEnergy {
  final String date;
  final double rebEnergy;
  final double generator1Energy;
  final double generator2Energy;
  final double solar1Energy;
  final double solar2Energy;
  final double generatorHr;
  final double powerCutsGen1;
  final double powerCutsGen2;
  final double totalLoadEnergy;
  final int generator2Hr;
  final double rebEnergyMod;

  YearlyTotalEnergy({
    required this.date,
    required this.rebEnergy,
    required this.generator1Energy,
    required this.generator2Energy,
    required this.solar1Energy,
    required this.solar2Energy,
    required this.generatorHr,
    required this.powerCutsGen1,
    required this.powerCutsGen2,
    required this.totalLoadEnergy,
    required this.generator2Hr,
    required this.rebEnergyMod,
  });

  factory YearlyTotalEnergy.fromJson(Map<String, dynamic> json) {
    return YearlyTotalEnergy(
      date: json['date'],
      rebEnergy: json['reb_energy'],
      generator1Energy: json['generator_1_energy'],
      generator2Energy: json['generator_2_energy'],
      solar1Energy: json['solar1_energy'],
      solar2Energy: json['solar2_energy'],
      generatorHr: json['generator_hr'],
      powerCutsGen1: json['power_cuts_gen1'],
      powerCutsGen2: json['power_cuts_gen2'],
      totalLoadEnergy: json['total_load_energy'],
      generator2Hr: json['generator2_hr'],
      rebEnergyMod: json['reb_energy_mod'],
    );
  }
}
*/




import 'dart:convert';

import 'package:button_json/operation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  late bool isOn = true;

  List<RebEnergyModel> rebEnergyList = <RebEnergyModel>[];
  List<YearlyTotalEnergy> yearlyEnergyList = <YearlyTotalEnergy>[];

  @override
  void initState() {
    super.initState();
    fetchData();
    switchIsOn();
  }

  Future<void> switchIsOn() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isOn = _prefs.getBool('isOn') ?? true;
    });
  }

  Future<void> _toggleIsOn() async {
    setState(() {
      isOn = false;
    });
    await _prefs.setBool('isOn', isOn);
  }

  Future<void> fetchData() async {
    final energyResponse = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/total-reb-energy/'),
      headers: {'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308'},
    );

    final yearlyEnergyResponse = await http.get(
      Uri.parse('https://scubetech.xyz/kazi-habibpur/yearly-total-energy/'),
      headers: {'Authorization': 'Token 264ae90790a4275c27829533c55800f05301e308'},
    );

    if (energyResponse.statusCode == 200 && yearlyEnergyResponse.statusCode == 200) {
      final energyJsonData = json.decode(energyResponse.body);
      final yearlyEnergyJsonData = json.decode(yearlyEnergyResponse.body);

      print("energyResponse : $energyJsonData");
      print("yearlyEnergyJsonData : $yearlyEnergyJsonData");

      if (mounted) {
        setState(() {
          rebEnergyList.add(RebEnergyModel.fromJson(energyJsonData));
          for (var item in yearlyEnergyJsonData) {
            yearlyEnergyList.add(YearlyTotalEnergy.fromJson(item));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton(
              onPressed: () {
                _toggleIsOn();
              },
              child: Text(isOn ? 'On' : 'Off'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isOn ? "Reb Energy: ${rebEnergyList.isNotEmpty ? rebEnergyList[0].totalRebEnergy : 'N/A'}" : "Power Sum: ${rebEnergyList.isNotEmpty ? rebEnergyList[0].totalPowerSum : 'N/A'}"),
            Text(isOn ? "generator_1_energy: ${yearlyEnergyList.isNotEmpty ? yearlyEnergyList[0].generator1Energy : 'N/A'}" : "reb_energy: ${yearlyEnergyList.isNotEmpty ? yearlyEnergyList[0].rebEnergy : 'N/A'}"),
            const SizedBox(height: 8.0,),
            const Text('Reb 2'),
            const SizedBox(height: 16.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isOn
                        ? OperationScreen(
                      isOn: true,
                      totalRebEnergy: rebEnergyList[0].totalRebEnergy,
                      generator1Energy: yearlyEnergyList[0].generator1Energy,
                    )
                        : OperationScreen(
                      isOn: false,
                      totalPowerSum: rebEnergyList[0].totalPowerSum,
                      rebEnergy: yearlyEnergyList[0].rebEnergy,
                    ),
                  ),
                );
              },
              child: const Text('Next Operation'),
            ),
          ],
        ),
      ),
    );
  }
}

class RebEnergyModel {
  final double totalPowerSum;
  final double totalRebEnergy;

  RebEnergyModel({
    required this.totalPowerSum,
    required this.totalRebEnergy,
  });

  factory RebEnergyModel.fromJson(Map<String, dynamic> json) {
    return RebEnergyModel(
      totalPowerSum: json['total_reb_energy_absolute'],
      totalRebEnergy: json['total_reb_energy'],
    );
  }
}

class YearlyTotalEnergy {
  final String date;
  final double rebEnergy;
  final double generator1Energy;
  final double generator2Energy;
  final double solar1Energy;
  final double solar2Energy;
  final double generatorHr;
  final double powerCutsGen1;
  final double powerCutsGen2;
  final double totalLoadEnergy;
  final int generator2Hr;
  final double rebEnergyMod;

  YearlyTotalEnergy({
    required this.date,
    required this.rebEnergy,
    required this.generator1Energy,
    required this.generator2Energy,
    required this.solar1Energy,
    required this.solar2Energy,
    required this.generatorHr,
    required this.powerCutsGen1,
    required this.powerCutsGen2,
    required this.totalLoadEnergy,
    required this.generator2Hr,
    required this.rebEnergyMod,
  });

  factory YearlyTotalEnergy.fromJson(Map<String, dynamic> json) {
    return YearlyTotalEnergy(
      date: json['date'],
      rebEnergy: json['reb_energy'],
      generator1Energy: json['generator_1_energy'],
      generator2Energy: json['generator_2_energy'],
      solar1Energy: json['solar1_energy'],
      solar2Energy: json['solar2_energy'],
      generatorHr: json['generator_hr'],
      powerCutsGen1: json['power_cuts_gen1'],
      powerCutsGen2: json['power_cuts_gen2'],
      totalLoadEnergy: json['total_load_energy'],
      generator2Hr: json['generator2_hr'],
      rebEnergyMod: json['reb_energy_mod'],
    );
  }
}

