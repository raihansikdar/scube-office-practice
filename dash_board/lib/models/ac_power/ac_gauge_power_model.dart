class AcGaugePowerModel {
  final double? acPlant;


  AcGaugePowerModel({this.acPlant});

  factory AcGaugePowerModel.fromJson(Map<String, dynamic> json) {
    return AcGaugePowerModel(
      acPlant: json['plant'],
    );
  }
}