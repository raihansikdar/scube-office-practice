import 'package:dash_board/models/gauge_power_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  const GaugeWidget({
    super.key,
    required this.gaugePowerModelData,
  });

  final GaugePowerModel? gaugePowerModelData;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: _buildRadialGauge(
                    title: 'Active AC Power',
                    value: gaugePowerModelData?.acPlant ?? 0.00,
                    startValue: 0,
                    endValue: 1600,
                    interval: 400,
                    minimum: 0,
                    maximum: 1600,
                    text: '${gaugePowerModelData?.acPlant?.toStringAsFixed(2) ?? 0.00} kW',
                    labelFormat: '{value} ',
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: _buildRadialGauge(
                    title: 'Live PR',
                    value: gaugePowerModelData?.prPlant ?? 0.00,
                    startValue: 0,
                    endValue: 2,
                    interval: 1,
                    minimum: 0,
                    maximum: 2,
                    text: gaugePowerModelData?.prPlant?.toStringAsFixed(2) ?? "0.00",
                    labelFormat: '{value}',
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: _buildRadialGauge(
                    title: 'Irr Average',
                    value: gaugePowerModelData?.poaAvg ?? 0.00,
                    startValue: 0,
                    endValue: 1200,
                    interval: 300,
                    minimum: 0,
                    maximum: 1200,
                    text:
                    '${gaugePowerModelData?.poaAvg?.toStringAsFixed(2) ?? "0.00"}  w/m²}',
                    labelFormat: '{value} ',
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: _buildRadialGauge(
                    title: 'Daily Cumulative Average',
                    value: gaugePowerModelData?.poaDayAvg ?? 0.00,
                    startValue: 0,
                    endValue: 10,
                    interval: 3,
                    minimum: 0,
                    maximum: 10,
                    text:
                    '${gaugePowerModelData?.poaDayAvg?.toStringAsFixed(2) ?? "0.00"} wh/m²}',
                    labelFormat: '{value} ',
                  ),
                ),
              ),
              // Add another Expanded for the fourth gauge here
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildRadialGauge(
    {required String title,
      required double value,
      required double startValue,
      required double endValue,
      required double interval,
      required double minimum,
      required double maximum,
      required String text,
      required String labelFormat}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 2.0,
    child: Column(
      children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
         // padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SfRadialGauge(
                    //enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                        startAngle: 180,
                        endAngle: 0,
                        interval: interval,
                        radiusFactor: 1.1,
                        minimum: minimum,
                        maximum: maximum,
                        showLabels: true,
                        labelFormat: labelFormat,
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: startValue,
                            endValue: endValue,
                            color: Colors.grey,
                            startWidth: 10,
                            endWidth: 10,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: value,
                            lengthUnit: GaugeSizeUnit.factor,
                            needleLength: 0.6,
                            needleEndWidth: 6,
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Colors.deepPurple,
                                Colors.deepPurple,
                                Colors.grey,
                                Colors.grey,
                              ],
                              stops: <double>[0, 0.5, 0.5, 1],
                            ),
                            needleColor: const Color(0xFFF67280),
                            knobStyle: const KnobStyle(
                              knobRadius: 0.05,
                              borderWidth: 0.02,
                              sizeUnit: GaugeSizeUnit.factor,
                              borderColor: Colors.deepPurple,
                              color: Colors.white,
                            ),
                          ),
                          RangePointer(
                            value: value,
                            width: 10,
                            enableAnimation: true,
                            color: Colors.deepPurple,
                          ),
                        ],

                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}