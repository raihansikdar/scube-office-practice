import 'dart:developer';
import 'package:dash_board/api_services/card_api_services.dart';
import 'package:dash_board/models/card_power_model.dart';
import 'package:dash_board/screens/Widgets/card_widget.dart';
import 'package:flutter/material.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

   CardPowerModel? cardPowerModelData;

  Future<void> fetchData() async {
    try {
      final cardData = await CardApiServices.cardFetchData();
      setState(() {
        cardPowerModelData = cardData;
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
      body: Column(
        children: [
          CardWidget(cardPowerModelData: cardPowerModelData),
        ],
      ),
    );
  }
}


