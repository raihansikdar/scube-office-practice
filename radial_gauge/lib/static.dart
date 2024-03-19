import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Radial Gauge',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
              backgroundColor: Colors.cyan,
              centerTitle: true,
            ),
            body: Container(
                height: 300,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 2.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Energy Intensity',
                            style: TextStyle(
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
                              height: 200,
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                  alignment: Alignment.center,
                                  children:[
                                    //SizedBox(height: 50,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: SfRadialGauge(
                                          enableLoadingAnimation: true, animationDuration: 4500,
                                          axes: <RadialAxis>[
                                            RadialAxis(
                                                startAngle: 180,
                                                endAngle: 0,
                                                radiusFactor: 1.1,
                                                minimum: 0, maximum: 500,interval: 100,
                                                showLabels: true,
                                                labelFormat: '{value}kw',
                                                ranges: <GaugeRange>[
                                                  GaugeRange(startValue: 0,endValue: 500,color: Colors.grey,startWidth: 13,endWidth: 13,),
                                                ],
                                                // pointers: const <GaugePointer>[NeedlePointer(value:220,enableAnimation: true,)],
                                                pointers: const <GaugePointer>[
                                                  NeedlePointer(
                                                      value: 220.0,
                                                      lengthUnit: GaugeSizeUnit.factor,
                                                      needleLength: 0.6,
                                                      needleEndWidth:  6,
                                                      gradient: LinearGradient(
                                                          colors: <Color>[
                                                            Colors.deepPurple,Colors.deepPurple,
                                                            Colors.grey,Colors.grey,
                                                          ],
                                                          stops: <double>[0, 0.5, 0.5, 1]),
                                                      needleColor: Color(0xFFF67280),
                                                      knobStyle: KnobStyle(
                                                          knobRadius: 0.05,
                                                          borderWidth: 0.02,
                                                          sizeUnit: GaugeSizeUnit.factor,
                                                          borderColor: Colors.deepPurple,
                                                          color: Colors.white)),
                                                  RangePointer(value: 220, width: 13, enableAnimation: true, color: Colors.deepPurple)
                                                ],
                                                annotations: const <GaugeAnnotation>[
                                                  GaugeAnnotation(widget: Text('220.0 kW',style: TextStyle(fontSize:16,fontWeight: FontWeight.w600,color: Colors.deepPurple)),
                                                      angle: 90,positionFactor: 0.25)]

                                            )
                                          ]
                                      ),
                                    )
                                  ]
                              )
                          ))]

                    )))
        )
    );
  }
}


