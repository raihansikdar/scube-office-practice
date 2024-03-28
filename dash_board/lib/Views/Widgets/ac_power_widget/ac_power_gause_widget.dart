import 'package:dash_board/models/ac_power/ac_gauge_power_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AcPowerGaugeWidget extends StatelessWidget {
   AcPowerGaugeWidget({
    super.key,
    required this.acGaugePowerModel,
  });

  AcGaugePowerModel? acGaugePowerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: _buildRadialGauge(
                    title: 'Active AC Power',
                    value: acGaugePowerModel?.acPlant ?? 0.00,
                    startValue: 0,
                    endValue: 1600,
                    interval: 400,
                    minimum: 0,
                    maximum: 1600,
                    text: '${acGaugePowerModel?.acPlant?.toStringAsFixed(2) ?? 0.00} kW',
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