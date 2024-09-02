import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'homeScreen.dart'; // Ensure this import is correct for your home screen

class QRPage extends StatelessWidget {
  final String qrData;

  QRPage({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.indigo],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(

          backgroundColor: Colors.transparent,
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'JanBahon',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 10),
              Icon(Icons.qr_code_2, color: Colors.indigo),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 300.0,
              ),
              SizedBox(height: 20), // Space between QR code and button
              SizedBox(width: 250,
               child:  MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homeS()),
                    );
                  },
                  height: 50,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, color: Colors.white),
                      SizedBox(width: 10), // Space between icon and text
                      Text(
                        'Home Screen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
