import 'package:dash_board/models/card_power_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.cardPowerModelData,
  });

  final CardPowerModel? cardPowerModelData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //----------- Generation-------
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Generation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25,),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              const TextSpan(text: "Today's Net : ", style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              TextSpan(
                                text: cardPowerModelData?.todayGeneration.toStringAsFixed(2) ?? '0.00',
                                style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0,),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: "Yesterday's Net : ", style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              TextSpan(
                                text: cardPowerModelData?.yesterdayGeneration.toStringAsFixed(2) ?? '0.00',
                                style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //----------- Temperature-------
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Temperature',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25,),

                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: "Module Temperature : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              TextSpan(
                                text: "${cardPowerModelData?.moduleTemp.toStringAsFixed(0) ?? '0.00'}°C",
                                style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0,),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: "30 min Average : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              TextSpan(
                                text: "${cardPowerModelData?.ambientTemp.toStringAsFixed(0) ?? '0.00'}°C",
                                style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //----------- Radiation-------
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Radiation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15.0,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "East : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${cardPowerModelData?.radiationEast.toStringAsFixed(2) ?? '0.00'} W/m²",
                                      style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),),
                              const SizedBox(width: 16.0,),
                              Expanded(child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "West : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${cardPowerModelData?.radiationWest.toStringAsFixed(2) ?? '0.00'} W/m²",
                                      style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),)
                            ],
                          ),
                          const SizedBox(height: 12.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "North : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${cardPowerModelData?.radiationNorth.toStringAsFixed(2) ?? '0.00'} W/m²",
                                      style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),),
                              const SizedBox(width: 16.0,),
                              Expanded(child:  Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: "South : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                    TextSpan(
                                      text: "${cardPowerModelData?.radiationSouth.toStringAsFixed(2) ?? '0.00'} W/m²",
                                      style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),)
                            ],
                          ),
                          const SizedBox(height: 12.0,),
                          FittedBox(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: "South 15°C : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                  TextSpan(
                                    text: "${cardPowerModelData?.radiationSouth15.toStringAsFixed(2) ?? '0.00'} W/m²",
                                    style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //----------- Gross Profit-------
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Gross Profit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40.0,),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                const TextSpan(text: "Gross Profit : ", style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                                TextSpan(
                                  text: "${cardPowerModelData?.energyCost.toStringAsFixed(2) ?? '0.00'} ৳",
                                  style: const TextStyle(fontSize:14.0,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}