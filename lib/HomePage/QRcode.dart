import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homeScreen.dart'; // Ensure this import is correct for your home screen
class QRPage extends StatelessWidget {
  final String qrData;
  final String uniqueID;

  QRPage({required this.qrData,required this.uniqueID});
  Future<void> _copyToClipboard(BuildContext context, String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PassNum copied to clipboard!')),
    );
  }
  void _launchURL(String qrdata) async
  {
    final Uri url= Uri.parse(qrdata);
    if(await launchUrl(url))
      {
        await launchUrl(url);
      }
    else
      {
        throw 'Could not launch $url';
      }
  }
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
              Text(
                'Congratulation',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      onPressed: () {
                        _copyToClipboard(context, uniqueID);
                      },
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.copy,color: Colors.white,),
                      mini: true, // Smaller button
                    ),
                  )
                ],
              ),
              SizedBox(height: 10), // Space between QR code and button
              SizedBox(width: 250,
               child:  Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       MaterialButton(
                         onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => homeS()),
                           );
                         },
                         height: 50,
                         color: Colors.indigo,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: Row(
                           //mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.home, color: Colors.white),
                           ],
                         ),
                       ),
                       SizedBox(width: 10),
                       MaterialButton(
                         onPressed: () {
                           _launchURL(qrData);
                         },
                         height: 50,
                         color: Colors.indigo,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: Row(
                           //mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.download, color: Colors.white),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
