class SpChartDataModel {
  final DateTime timedate;
  final double radiationEast;
  final double radiationWest;
  final double radiationNorth;
  final double radiationSouth;

  SpChartDataModel({required this.timedate, required this.radiationEast, required this.radiationWest, required this.radiationNorth, required this.radiationSouth});


  factory SpChartDataModel.fromJson(Map<String,dynamic>json){
    return SpChartDataModel(
      timedate: DateTime.parse(json['timedate']),
      radiationEast: json['radiation_east'],
      radiationWest: json['radiation_west'],
      radiationNorth: json['radiation_north'],
      radiationSouth: json['radiation_south'],
    );
  }
}