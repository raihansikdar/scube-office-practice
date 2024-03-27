import 'dart:developer';
import 'package:dash_board/Views/Screens/dgr_screen.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/card_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/gauge_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/line_chart_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/sidebar_menu_widget.dart';
import 'package:dash_board/Views/Widgets/dash_board_widget/table_widget.dart';
import 'package:dash_board/api_services/card_api_services.dart';
import 'package:dash_board/api_services/gauge_api_services.dart';
import 'package:dash_board/api_services/line_chart_api_service.dart';
import 'package:dash_board/api_services/table_api_services.dart';
import 'package:dash_board/models/card_power_model.dart';
import 'package:dash_board/models/gauge_power_model.dart';
import 'package:dash_board/models/power_chart_data_model.dart';
import 'package:dash_board/models/sp_chart_dara_model.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DashBoardScreen extends StatefulWidget {

  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();



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

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text(
           "SQ Group",
         ),
         centerTitle: true,
       ),

       body: Row(
         children: [
           SidebarMenuWidget(sideMenu: sideMenu),

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












