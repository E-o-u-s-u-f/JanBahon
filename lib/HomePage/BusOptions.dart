import 'package:flutter/material.dart';

import 'bus_seat_selection.dart';

Widget buildBoxB(BuildContext context, String FROM, String FROM1, String TO, String TO1, String date, String time, String no) {
  return InkWell(
    onTap: () {
      // Handle tap event here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BusSeatSelection()),
      );
    },
    child: Container(
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
                        color: Colors.black,
                      ),
                    ),
                    Text(FROM1,
                      style: TextStyle(
                        color: Colors.black, // Example color
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.airport_shuttle,
                size: 32,
                color: Colors.black,
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
                        color: Colors.black,
                      ),
                    ),
                    Text(TO1,style: TextStyle(
                      color: Colors.black, // Example color
                    ),),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(thickness: 1, color: Colors.black),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date', style: TextStyle(color: Colors.black)),
                    Text(date,style: TextStyle(
                      color: Colors.black, // Example color
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bus', style: TextStyle(color: Colors.black)),
                    Text(no,style: TextStyle(
                      color: Colors.black, // Example color
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Time', style: TextStyle(color: Colors.black)),
                    Text(time,style: TextStyle(
                      color: Colors.black, // Example color
                    ),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

