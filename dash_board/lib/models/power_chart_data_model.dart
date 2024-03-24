class PowerChartDataModel{
  final DateTime timedate;
  final double plant;

  PowerChartDataModel({required this.timedate, required this.plant});

  factory PowerChartDataModel.fromJson(Map<String,dynamic>json){
    return PowerChartDataModel( timedate: DateTime.parse(json['timedate']), plant: json['plant']);
  }
}