import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class BusOption extends StatefulWidget {

  const BusOption({Key? key}) : super(key: key);

  @override
  State<BusOption> createState() => _BusOptionState();
}

class _BusOptionState extends State<BusOption> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: SingleChildScrollView(
           child: Container(
             padding: EdgeInsets.all(16.0),
             child: Column(
               //mainAxisAlignment: MainAxisAlignment.start,
               //crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 buildBox("DHA","Dhaka","CHA","Chittagong","23-05-2024","02:35 am","BU1234"),
                 buildBox("RAN","Rangpur","RAJ","Rajshahi","23-05-2024","04:35 am","UB1234"),
                 buildBox("SYL","Sylhet","KHU","Khulna","23-05-2024","06:35 am","UL1234"),
                 buildBox("BAR","Barisal","MYM","Mymensingh","23-05-2024","09:35","KL0564"),
                 buildBox("FAR","Faridpur","MUN","Munshiganj","24-05-2024","12:00 am","NI4207"),
                 buildBox("RAJ","Rajshahi","DHA","Dhaka","24-05-2024","02:35 am","JO2454"),
                 buildBox("KHU","Khulna","BAR","Barisal","24-05-2024","01:35 am","ro3024"),



               ],
             ),
           ),
         ),

      ),

    );
  }
  Widget buildBox(String FROM,String FROM1,String TO,String TO1,String date,String time,String no) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FROM,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(FROM1),
                  ],
                ),
              ),
              Icon(
                Icons.airport_shuttle,
                size: 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      TO,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(TO1),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(thickness: 1, color: Colors.grey),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date', style: TextStyle(color: Colors.grey)),
                    Text(date),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bus', style: TextStyle(color: Colors.grey)),
                    Text(no),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Time', style: TextStyle(color: Colors.grey)),
                    Text(time),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
