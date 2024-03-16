import 'package:flutter/material.dart';

class OperationScreen extends StatelessWidget {
  const OperationScreen({super.key, required this.isOn, this.totalPowerSum, this.totalRebEnergy, this.generator1Energy, this.rebEnergy});
   final bool isOn;
  final double? totalPowerSum;
  final double? totalRebEnergy;
  final double? generator1Energy;
  final double? rebEnergy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Screen'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( isOn ?  "Reb Energy: $totalRebEnergy" : "Power Sum:$totalPowerSum" ),
            Text( isOn ?  "generator1Energy: $generator1Energy" : "rebEnergy:$rebEnergy" ),
          ],
        ),
      ),
    );
  }
}
