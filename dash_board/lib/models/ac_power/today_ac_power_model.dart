class TodayAcPowerModel {
  final String timedate;
  final double plant;

  TodayAcPowerModel({
    required this.timedate,
    required this.plant,
  });

  factory TodayAcPowerModel.fromJson(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json['timedate']);
    final String formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    final double formattedPlant = double.parse(json['plant'].toStringAsFixed(2));

    return TodayAcPowerModel(
      timedate: formattedDate,
      plant: formattedPlant,
    );
  }

  String formattedPlantWithUnit() {
    return '${plant.toStringAsFixed(2)} kW';
  }
}
