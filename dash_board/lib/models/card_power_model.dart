class CardPowerModel{
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

  CardPowerModel({required this.todayGeneration, required this.yesterdayGeneration, required this.moduleTemp, required this.ambientTemp, required this.radiationEast, required this.radiationWest, required this.radiationNorth, required this.radiationSouth, required this.radiationSouth15, required this.energyCost});

  factory CardPowerModel.fromJson(Map<String,dynamic>json){
    return CardPowerModel(
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