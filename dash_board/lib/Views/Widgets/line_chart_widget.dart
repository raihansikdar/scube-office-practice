import 'package:dash_board/models/power_chart_data_model.dart';
import 'package:dash_board/models/sp_chart_dara_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChartWidget extends StatelessWidget {
  const SplineChartWidget({
    super.key,
    required this.spChartData,
    required this.powerChartData,
  });

  final List<SpChartDataModel> spChartData;
  final List<PowerChartDataModel> powerChartData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(text: 'Daily Radiation and Power',borderWidth: 10,backgroundColor: Colors.deepPurple,textStyle: TextStyle(color: Colors.white,)),
      legend: const Legend(isVisible: true, position: LegendPosition.top),
      trackballBehavior: TrackballBehavior(
        enable: true,
        tooltipAlignment: ChartAlignment.near,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        activationMode: ActivationMode.singleTap,
      ),
      series: <CartesianSeries>[
        SplineSeries<SpChartDataModel, DateTime>(
          name: 'Radiation East',
          dataSource: spChartData,
          pointColorMapper:(SpChartDataModel data, _) => Colors.blueGrey,
          xValueMapper: (SpChartDataModel data, _) => data.timedate,
          yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationEast.toStringAsFixed(2)),
        ),
        SplineSeries<SpChartDataModel, DateTime>(
          name: 'Radiation West',
          dataSource: spChartData,
          pointColorMapper:(SpChartDataModel data, _) => Colors.deepPurple,
          xValueMapper: (SpChartDataModel data, _) => data.timedate,
          yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationWest.toStringAsFixed(2)),
        ),
        SplineSeries<SpChartDataModel, DateTime>(
          name: 'Radiation North',
          dataSource: spChartData,
          pointColorMapper:(SpChartDataModel data, _) => Colors.amber,
          xValueMapper: (SpChartDataModel data, _) => data.timedate,
          yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationNorth.toStringAsFixed(2)),
        ),
        SplineSeries<SpChartDataModel, DateTime>(
          name: 'Radiation South',
          dataSource: spChartData,
          pointColorMapper:(SpChartDataModel data, _) => Colors.white10,
          xValueMapper: (SpChartDataModel data, _) => data.timedate,
          yValueMapper: (SpChartDataModel data, _) => double.parse(data.radiationSouth.toStringAsFixed(2)),
        ),

        //---------power-------------
        SplineSeries<PowerChartDataModel, DateTime>(
          name: 'Power',
          dataSource: powerChartData,
          pointColorMapper:(PowerChartDataModel data, _) => Colors.red,
          xValueMapper: (PowerChartDataModel data, _) => data.timedate,
          yValueMapper: (PowerChartDataModel data, _) => double.parse(data.plant.toStringAsFixed(2)),
        ),

      ],
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.Hm(),
        minimum: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0),
        maximum: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 24),
        interval: 1,
        //edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: const NumericAxis(
        labelFormat: '{value}',
      ),
    );
  }
}