import 'package:flutter/material.dart';

import '../../Seat&BuyTicket/bus_seat_selection.dart';

Widget buildBoxTrain(BuildContext context, String FROM, String FROM1, String TO, String TO1, String date, String time, String no) {
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
                      ),
                    ),
                    Text(FROM1),
                  ],
                ),
              ),
              Icon(
                Icons.train,
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
                    Text('Train', style: TextStyle(color: Colors.grey)),
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
    ),
  );
}

