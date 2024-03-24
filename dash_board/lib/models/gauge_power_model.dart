class GaugePowerModel {
  final double? acPlant;
  final double? prPlant;
  final double? poaAvg;
  final double? poaDayAvg;

  GaugePowerModel({this.acPlant,this.prPlant, this.poaAvg, this.poaDayAvg});

  factory GaugePowerModel.fromJson(Map<String, dynamic> json) {
    return GaugePowerModel(
      acPlant: json['plant'],
      prPlant: json['plant'],
      poaAvg: json['poa_avg'],
      poaDayAvg: json['poa_day_avg'],
    );
  }
}