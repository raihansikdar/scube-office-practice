/*
class PieChartModel {
  double? percentageReb;
  int? percentageGenerator1;
  int? percentageGenerator2;
  double? percentageSolar1;
  double? percentageSolar2;

  PieChartModel(
      {this.percentageReb,
        this.percentageGenerator1,
        this.percentageGenerator2,
        this.percentageSolar1,
        this.percentageSolar2});

  PieChartModel.fromJson(Map<String, dynamic> json) {
    percentageReb = json['percentage_reb'];
    percentageGenerator1 = json['percentage_generator_1'];
    percentageGenerator2 = json['percentage_generator_2'];
    percentageSolar1 = json['percentage_solar1'];
    percentageSolar2 = json['percentage_solar2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage_reb'] = percentageReb;
    data['percentage_generator_1'] = percentageGenerator1;
    data['percentage_generator_2'] = percentageGenerator2;
    data['percentage_solar1'] = percentageSolar1;
    data['percentage_solar2'] = percentageSolar2;
    return data;
  }
}*/
class PieChartModel {
  double? percentageReb;
  int? percentageGenerator1;
  int? percentageGenerator2;
  double? percentageSolar1;
  double? percentageSolar2;

  PieChartModel({
    this.percentageReb,
    this.percentageGenerator1,
    this.percentageGenerator2,
    this.percentageSolar1,
    this.percentageSolar2,
  });

  factory PieChartModel.fromJson(Map<String, dynamic> json) {
    return PieChartModel(
      percentageReb: json['percentage_reb']?.toDouble(),
      percentageGenerator1: json['percentage_generator_1']?.toInt(),
      percentageGenerator2: json['percentage_generator_2']?.toInt(),
      percentageSolar1: json['percentage_solar1']?.toDouble(),
      percentageSolar2: json['percentage_solar2']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'percentage_reb': percentageReb,
      'percentage_generator_1': percentageGenerator1,
      'percentage_generator_2': percentageGenerator2,
      'percentage_solar1': percentageSolar1,
      'percentage_solar2': percentageSolar2,
    };
  }
}