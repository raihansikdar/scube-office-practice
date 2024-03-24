class InverterModel {
  final String name;
  final dynamic timeDate;
  final dynamic energy;
  final dynamic pr;
  final dynamic acMaxPower;
  final dynamic dcMaxPower;
  final dynamic specificYield;

  InverterModel({required this.name, this.timeDate, required this.energy, required this.pr, required this.acMaxPower, required this.dcMaxPower, required this.specificYield});

}