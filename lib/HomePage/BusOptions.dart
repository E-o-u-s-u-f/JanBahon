import 'package:flutter/material.dart';

import 'bus_seat_selection.dart';

Widget buildBoxB(BuildContext context, String FROM, String FROM1, String TO,
    String TO1, String date, String time, String no, int cur, String money) {
  String description = "Bus";
  IconData getIcon(int cur) {
    switch (cur) {
      case 0:
        description = "Bus";
        return Icons.airport_shuttle; // Bus icon
      case 1:
        description = "Train";
        return Icons.train; // Train icon
      case 2:
        description = "Airplane";
        return Icons.airplanemode_active; // Airplane icon
      default:
        description = "Bus";
        return Icons.directions_bus; // Default icon (bus)
    }
  }

  IconData icon = getIcon(cur);
  return InkWell(
    onTap: () {
      // Handle tap event here
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusSeatSelection(
            FROM: FROM,
            TO: TO,
            Time: time,
            date: date,
            no: no,
            description: description,
            Fair: money,
          ),
        ),
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
                      ),
                    ),
                    Text(FROM1),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, size: 32),
                    Text(no),
                  ],
                ),
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
                    Text('Ammount', style: TextStyle(color: Colors.grey)),
                    Text(
                         '$money ৳' ,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                         ),
                      ),
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
    ),
  );
}
