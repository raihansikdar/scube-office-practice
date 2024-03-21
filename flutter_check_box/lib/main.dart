import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool load = true;
  bool source = true;
  bool reb = true;
  bool generator01 = true;
  bool generator02 = true;
  bool solar01 = true;
  bool solar02 = true;

  bool areAllChildCheckboxesFalse() {
    return !reb && !generator01 && !generator02 && !solar01 && !solar02;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check box'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    load = !load;
                                  });
                                },
                                child:  Icon(load ? Icons.arrow_drop_down : Icons.arrow_right)),
                            Checkbox(
                              value: load,
                              onChanged: (val) {
                                setState(() {
                                  load = val!;
                                });
                              },
                            ),
                            const SizedBox(width: 8.0),
                            const Text('Load'),
                          ],
                        ),
                        if (load)
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: load,
                                  onChanged: (val) {
                                    setState(() {
                                      load = val!;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8.0),
                                const Text('Load Power'),
                              ],
                            ),
                          ),
                      ],
                    ),

                   const SizedBox(height: 16.0),
                    //---------------------------Source-------------------------------
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    source = !source;
                                  });
                                },
                                child:  Icon(load ? Icons.arrow_drop_down : Icons.arrow_right)),
                            Checkbox(
                              value: source,
                              onChanged: (val) {
                                setState(() {
                                  source = val!;
                                  reb = true;
                                  generator01 = true;
                                  generator02 = true;
                                  solar01 = true;
                                  solar02 = true;
                                });
                              },
                            ),
                            const SizedBox(width: 8.0),
                            const Text('Source'),
                          ],
                        ),
                        //---------------------------Element of Source-------------------------------
                        if (source)
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: reb,
                                      onChanged: (val) {
                                        setState(() {
                                          reb = val!;
                                          if (!val && areAllChildCheckboxesFalse()) {
                                            source = false;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text('REB'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: generator01,
                                      onChanged: (val) {
                                        setState(() {
                                          generator01 = val!;
                                          if (!val && areAllChildCheckboxesFalse()) {
                                            source = false;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text('Generator 01'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: generator02,
                                      onChanged: (val) {
                                        setState(() {
                                          generator02 = val!;
                                          if (!val && areAllChildCheckboxesFalse()) {
                                            source = false;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text('Generator 02'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: solar01,
                                      onChanged: (val) {
                                        setState(() {
                                          solar01 = val!;
                                          if (!val && areAllChildCheckboxesFalse()) {
                                            source = false;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text('Solar 1'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: solar02,
                                      onChanged: (val) {
                                        setState(() {
                                          solar02 = val!;
                                          if (!val && areAllChildCheckboxesFalse()) {
                                            source = false;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text('Solar 2'),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
