import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class DGRScreen extends StatefulWidget {
  const DGRScreen({super.key});

  @override
  State<DGRScreen> createState() => _DGRScreenState();
}

class _DGRScreenState extends State<DGRScreen> {

  // String selectFirstData = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // String selectLastData =  DateFormat("yyyy-MM-dd").format(DateTime.now());

  String selectFirstData = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now());
  String selectLastData = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now());
  bool pr =true;
  bool acPower =true;
  bool irr =true;
  bool todayEnergy =true;
  bool isLoading = false;

  late List<DgrModel>dgrList = [];

  Future<void> fetchFilterData(String startDate,String endDate) async {
    const _baseUrl = 'http://192.168.60.60:8000';
    const String authToken = '';
    const endPoint = '/filter-dgr-data/';

     setState(() {
       isLoading = true;
     });

    final response = await http.post(
      Uri.parse(_baseUrl + endPoint), headers: {"Content-Type": "application/json",'Authorization': authToken}, body: json.encode({
        "start": startDate,
        "end": endDate,
      }),
    );
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        dgrList = responseData.map<DgrModel>((json) => DgrModel.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
      fetchFilterData(selectFirstData, selectLastData);
    super.initState();
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
                    onPressed: (){
                        fetchFilterData(selectFirstData, selectLastData);
                    }, child: const Text('Submit'))
              ],
            ),
             const SizedBox(height: 10.0,),
            Row(
              children: [
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
                                activeColor: Colors.deepPurple,
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
                                activeColor: Colors.deepPurple,
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
                                activeColor: Colors.deepPurple,
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
                                activeColor: Colors.deepPurple,
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
                ),
                const SizedBox(width: 20,),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    :
                Expanded(
                      child: SfCartesianChart(
                        title: const ChartTitle(text: 'Selected Data DGR',borderWidth: 10,backgroundColor: Colors.deepPurple,textStyle: TextStyle(color: Colors.white,)),
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          tooltipAlignment: ChartAlignment.near,
                          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                          activationMode: ActivationMode.singleTap,
                        ),
                        primaryXAxis: DateTimeAxis(
                          dateFormat: DateFormat('dd/MM/yyyy'),
                          //minimum: DateTime.now().subtract(const Duration(days: 7)),
                          //maximum: DateTime.now(),
                          minimum: dgrList.isNotEmpty ? null : DateTime.parse(selectFirstData),
                          maximum: dgrList.isNotEmpty ? null : DateTime.parse(selectLastData),
                        ),
                      series: <CartesianSeries>[
                        if (pr)
                          SplineSeries<DgrModel, DateTime>(
                            name: 'PR',
                            dataSource: dgrList,
                            pointColorMapper: (DgrModel data, _) => Colors.amber,
                            xValueMapper: (DgrModel dgr, _) => dgr.timedate,
                            yValueMapper: (DgrModel dgr, _) => dgr.pr,
                          ),
                         if(acPower)
                           SplineSeries<DgrModel, DateTime>(
                             dataSource: dgrList,
                             pointColorMapper:(DgrModel data, _) => Colors.deepPurple,
                             xValueMapper: (DgrModel dgr, _) => dgr.timedate,
                             yValueMapper: (DgrModel dgr, _) => dgr.acPower,
                             name: 'AC Power',
                           ),
                        if(irr)
                          SplineSeries<DgrModel, DateTime>(
                            dataSource: dgrList,
                            pointColorMapper:(DgrModel data, _) => Colors.black,
                            xValueMapper: (DgrModel dgr, _) => dgr.timedate,
                            yValueMapper: (DgrModel dgr, _) => dgr.irr,
                            name: 'Irr',
                          ),
                        if(todayEnergy)
                          SplineSeries<DgrModel, DateTime>(
                            dataSource: dgrList,
                            pointColorMapper:(DgrModel data, _) => Colors.brown,
                            xValueMapper: (DgrModel dgr, _) => dgr.timedate,
                            yValueMapper: (DgrModel dgr, _) => dgr.todayEnergy,
                            name: 'Today Energy',
                          )
                      ],
                      ),
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
 /* void firstDatePicker() async{
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now().toLocal(),
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
  }*/

  void firstDatePicker() async{
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2130),
    );

    if(_datePicker != null){
      TimeOfDay? _timePicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (_timePicker != null) {
        DateTime selectedDateTime = DateTime(
          _datePicker.year,
          _datePicker.month,
          _datePicker.day,
          _timePicker.hour,
          _timePicker.minute,
        );

        String formattedDateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(selectedDateTime);
        selectFirstData = formattedDateTime;
        log(selectedDateTime.toString());
        setState(() {});
      }
    }
  }

  void lastDatePicker() async{
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2130),
    );

    if(_datePicker != null){
      TimeOfDay? _timePicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (_timePicker != null) {
        DateTime selectedDateTime = DateTime(
          _datePicker.year,
          _datePicker.month,
          _datePicker.day,
          _timePicker.hour,
          _timePicker.minute,
        );

        String formattedDateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(selectedDateTime);
        selectLastData = formattedDateTime;
        setState(() {});
      }
    }
  }





}

class DgrModel {
  DateTime timedate;
  double pr;
  double acPower;
  double irr;
  double todayEnergy;

  DgrModel({
    required this.timedate,
    required this.pr,
    required this.acPower,
    required this.irr,
    required this.todayEnergy,
  });

  factory DgrModel.fromJson(Map<String, dynamic> json) => DgrModel(
    timedate: DateTime.parse(json["timedate"]),
    pr: json["pr"]?.toDouble(),
    acPower: json["ac_power"]?.toDouble(),
    irr: json["irr"]?.toDouble(),
    todayEnergy: json["today_energy"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "timedate": timedate.toIso8601String(),
    "pr": pr,
    "ac_power": acPower,
    "irr": irr,
    "today_energy": todayEnergy,
  };
}
