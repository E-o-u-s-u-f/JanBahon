import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  final String qrData;

  QRPage({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:BoxDecoration(
        gradient:LinearGradient(begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white,Colors.indigo] )),
    child:
    Scaffold(
    backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 300.0,
        ),
      ),
    )
    );
  }
}
