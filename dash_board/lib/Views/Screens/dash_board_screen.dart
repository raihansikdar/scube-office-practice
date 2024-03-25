import 'dart:developer';
import 'package:dash_board/Views/Screens/dgr_screen.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/card_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/gauge_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/line_chart_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/table_widget.dart';
import 'package:dash_board/api_services/card_api_services.dart';
import 'package:dash_board/api_services/gauge_api_services.dart';
import 'package:dash_board/api_services/line_chart_api_service.dart';
import 'package:dash_board/api_services/table_api_services.dart';
import 'package:dash_board/models/card_power_model.dart';
import 'package:dash_board/models/gauge_power_model.dart';
import 'package:dash_board/models/power_chart_data_model.dart';
import 'package:dash_board/models/sp_chart_dara_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DashBoardScreen extends StatefulWidget {

  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

   CardPowerModel? cardPowerModelData;
   GaugePowerModel? gaugePowerModelData;
   late InverterDataSource inverterDataSource = InverterDataSource(inverterModelData: []);
   List<SpChartDataModel> spChartData = [];
   List<PowerChartDataModel> powerChartData = [];

  Future<void> fetchData() async {
    try {
      final cardData = await CardApiServices.fetchCardData();
      final gaugeData = await GaugeApiService.fetchGaugeData();
      final todayData = await TableApiService.fetchTableData('/single-today-data/');
      final yesterdayData = await TableApiService.fetchTableData('/single-yesterday-data/');
      final Map<String, dynamic> responseData = await LineChartApiService.fetchLineChartData();

      setState(() {
        cardPowerModelData = cardData;
        gaugePowerModelData = gaugeData;
        final allData = [...todayData, ...yesterdayData];
        inverterDataSource = InverterDataSource(inverterModelData: allData);

        spChartData = (responseData['radiation_today'] as List).map((e) => SpChartDataModel.fromJson(e)).toList();
        powerChartData = (responseData['power_today'] as List).map((e) => PowerChartDataModel.fromJson(e)).toList();
      });
    } catch (e) {

      log('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQ Group",),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CardWidget(cardPowerModelData: cardPowerModelData),
              GaugeWidget(gaugePowerModelData: gaugePowerModelData),
              const SizedBox(height: 4,),
              TableWidget(inverterDataSource: inverterDataSource),
              Container(
                height: 320,
                  transform: Matrix4.translationValues(0.0, -170.0, 0.0),

                  child: SplineChartWidget(spChartData: spChartData, powerChartData: powerChartData)),
            ],
          ),
        ),
      ),
    );
  }

*/



   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text(
           "SQ Group",
         ),
         centerTitle: true,
       ),
       // drawer: Drawer(
       //   child: ListView(
       //     children: [
       //       const DrawerHeader(
       //         decoration: BoxDecoration(
       //           color: Colors.blue,
       //         ),
       //         child: Text(
       //           'Navigation Menu',
       //           style: TextStyle(
       //             color: Colors.white,
       //             fontSize: 24,
       //           ),
       //         ),
       //       ),
       //       ListTile(
       //         title: const Text('Menu Item 1'),
       //         onTap: () {
       //           // Handle your navigation here
       //         },
       //       ),
       //       ListTile(
       //         title: const Text('Menu Item 2'),
       //         onTap: () {
       //           // Handle your navigation here
       //         },
       //       ),
       //       // Add more ListTile widgets for additional menu items
       //     ],
       //   ),
       // ),
       body: Row(
         children: [
           Drawer(
             backgroundColor: Colors.deepPurple,
             child: ListView(
               children: [
                  DrawerHeader(
                   decoration: const BoxDecoration(
                     //color: Colors.deepPurple,
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/images/logo.png',height: 110,),
                       const SizedBox(height: 8.0,),
                       const Text("Solar Monitoring System",style: TextStyle(color: Colors.white),)
                     ],
                   )
                 ),

                 ListTile(
                   title: const Row(
                 children: [
                   Icon(Icons.home,color: Colors.white,),
                     SizedBox(width: 16.0,),
                     Text('Home',style: TextStyle(color: Colors.white),)
                 ],
                 ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       Icon(Icons.tv,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('DGR',style: TextStyle(color: Colors.white),)
                     ],
                   ),
                   onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const DGRScreen()));
                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       Icon(Icons.analytics_outlined,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('Analysis',style: TextStyle(color: Colors.white),),
                       SizedBox(width: 128.0,),
                       Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                     ],
                   ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                      FaIcon(FontAwesomeIcons.houseMedical,size: 18.0,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('ShedWise',style: TextStyle(color: Colors.white),),
                       SizedBox(width: 120.0,),
                       Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                     ],
                   ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       FaIcon(FontAwesomeIcons.temperatureQuarter,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('Temperature',style: TextStyle(color: Colors.white),),

                     ],
                   ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       FaIcon(FontAwesomeIcons.radiation,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('Radiation',style: TextStyle(color: Colors.white),)
                     ],
                   ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       Icon(Icons.power,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('AC Power',style: TextStyle(color: Colors.white),)
                     ],
                   ),
                   onTap: () {

                   },
                 ),
                 ListTile(
                   title: const Row(
                     children: [
                       Icon(Icons.person,color: Colors.white,),
                       SizedBox(width: 16.0,),
                       Text('Profile',style: TextStyle(color: Colors.white),)
                     ],
                   ),
                   onTap: () {

                   },
                 ),
               ],
             ),
           ),
           Expanded(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     CardWidget(cardPowerModelData: cardPowerModelData),
                     GaugeWidget(gaugePowerModelData: gaugePowerModelData),
                     const SizedBox(height: 4,),
                     TableWidget(inverterDataSource: inverterDataSource),
                     Container(
                       height: 320,
                       transform: Matrix4.translationValues(0.0, -170.0, 0.0),
                       child: SplineChartWidget(spChartData: spChartData, powerChartData: powerChartData),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ],
       ),
     );
   }

  }










