import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DGRScreen extends StatefulWidget {
  const DGRScreen({super.key});

  @override
  State<DGRScreen> createState() => _DGRScreenState();
}

class _DGRScreenState extends State<DGRScreen> {

  String? selectFirstData;
  String? selectLastData;
  bool pr =true;
  bool acPower =true;
  bool irr =true;
  bool todayEnergy =true;

  late List<DgrModel>dgrList = [];

  Future<void> fetchFilterData() async {
    const _baseUrl = 'http://192.168.60.60:8000';
    const String authToken = '';
    const endPoint = '/filter-dgr-data/';

    final response = await http.post(
      Uri.parse(_baseUrl + endPoint), headers: {"Content-Type": "application/json,'Authorization': authToken"}, body: json.encode({
        "start": "2024-03-01 11:23:00.653",
        "end": "2024-03-24 11:25:29.960",
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        dgrList = responseData.map<DgrModel>((json) => DgrModel.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DGR Screen'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Start Data:"),
                const SizedBox(width: 8.0,),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                  firstDatePicker();
                }, child:  Text( selectFirstData ?? "Select data")),
                const SizedBox(width: 8.0,),
                const Text('End Date:'),
                const SizedBox(width: 8.0,),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                  lastDatePicker();
                }, child: Text(selectLastData ?? 'Select data')),
                const SizedBox(width: 16.0,),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){}, child: const Text('Submit'))
              ],
            ),
             const SizedBox(height: 10.0,),


             //------------------Power card-------------
             SizedBox(
               width: 180,
               child: Card(
                 shape: RoundedRectangleBorder(
                   side: const BorderSide(
                     color: Colors.deepPurple,
                     width: 1.0,
                   ),
                   borderRadius: BorderRadius.circular(8.0),
                 ),
                child: Column(
                  children: [
                   const Padding(
                     padding: EdgeInsets.all(12.0),
                     child: Row(
                       children: [
                         Text("Data",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600),),
                         Spacer(),
                         Text("Show",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600),),
                       ],
                     ),
                   ),
                    const Divider(
                     color: Colors.deepPurple,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Text('PR'),
                         const Spacer(),
                          Checkbox(
                            // fillColor: Colors.grey,
                            // checkColor: Colors.deepPurple,
                            value: pr,
                            onChanged: (val) {
                              setState(() {
                                pr = val!;
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.deepPurple,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Text('AC Power'),
                          const Spacer(),
                          Checkbox(
                            // fillColor: Colors.grey,
                            // checkColor: Colors.deepPurple,
                            value: acPower,
                            onChanged: (val) {
                              setState(() {
                                acPower = val!;
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.deepPurple,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Text('Irr'),
                          const Spacer(),
                          Checkbox(
                            // fillColor: Colors.grey,
                            // checkColor: Colors.deepPurple,
                            value: irr,
                            onChanged: (val) {
                              setState(() {
                                irr = val!;
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.deepPurple,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 12.0),
                      child: Row(
                        children: [
                          const Text('Today Energy'),
                          const Spacer(),
                          Checkbox(
                            value: todayEnergy,
                            onChanged: (val) {
                              setState(() {
                                todayEnergy = val!;
                              });
                            },
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
    );
  }

  void firstDatePicker() async{
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2130),
    );

    if(_picker != null){
      String formattedDate = DateFormat("yyyy-MM-dd").format(_picker);
      selectFirstData = formattedDate.toString();
      setState(() {});
    }
  }
  void lastDatePicker() async{
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2130),
    );

    if(_picker != null){
      String formattedDate = DateFormat("yyyy-MM-dd").format(_picker);
      selectLastData = formattedDate.toString();
      setState(() {});
    }
  }
}
class DgrModel {
  String? timedate;
  double? pr;
  int? acPower;
  int? irr;
  double? todayEnergy;

  DgrModel({this.timedate, this.pr, this.acPower, this.irr, this.todayEnergy});

  DgrModel.fromJson(Map<String, dynamic> json) {
    timedate = json['timedate'];
    pr = json['pr'];
    acPower = json['ac_power'];
    irr = json['irr'];
    todayEnergy = json['today_energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['timedate'] = timedate;
    data['pr'] = pr;
    data['ac_power'] = acPower;
    data['irr'] = irr;
    data['today_energy'] = todayEnergy;
    return data;
  }
}