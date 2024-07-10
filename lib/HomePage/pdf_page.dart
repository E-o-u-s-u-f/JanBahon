import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'QRcode.dart';
//import 'PaymentOption.dart';
import 'homeScreen.dart';
import 'dart:math';

class PDFPage extends StatefulWidget {
  final Set<int> selectedSeats;
  final String FROM;
  final String TO;
  final String Time;
  final String date;
  final String no;
  final String description;

  PDFPage({
    required this.selectedSeats,
    required this.FROM,
    required this.TO,
    required this.Time,
    required this.date,
    required this.no,
    required this.description,
  });

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _pdfUrl;

  Future<void> _generatePdfAndUpload() async {
    final pdf = pw.Document();
    final random = Random();
    final uniqueId = (random.nextInt(900000) + 100000).toString();
    final name = _nameController.text;
    final email = _emailController.text;
    final selectedSeats = widget.selectedSeats.toList();
    final no = widget.no;
    final FROM = widget.FROM;
    final TO = widget.TO;
    final Time = widget.Time;
    final date = widget.date;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'Dear $name,',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.teal,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Thank you for booking with Janbahon! Your journey with us is more than just a ticket - It is a gateway to new adventures and cherished memories. Here are Your Tickets:',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                ),
                textAlign: pw.TextAlign.justify,
              ),
              for (var seatNumber in selectedSeats)
                pw.Text(
                  'Seat Number: $seatNumber',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
              pw.Text(
                'Vehicle Number: $no',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                '  $FROM ----------------> $TO',
                style: pw.TextStyle(
                  fontSize: 18,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                ' TIME: $Time',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'PassNum : $uniqueId',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'DATE : $date',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Safe travels, and we look forward to being part of your next adventure!',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                ),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'Warmest regards, ',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                ),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'The Janbahon Team ',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.black,
                ),
                textAlign: pw.TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );

    try {
      // Generate the PDF file
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/tickets_$uniqueId.pdf");
      await file.writeAsBytes(await pdf.save());

      // Upload the PDF to Firebase Storage
      final storageRef = _storage.ref().child("user_tickets/$uniqueId.pdf");
      await storageRef.putFile(file);

      // Get the download URL
      final pdfUrl = await storageRef.getDownloadURL();

      // Store the URL and data in Firestore with custom document ID
      await _firestore.doc('users/$uniqueId').set({
        'name': name,
        'email': email,
        'pdfUrl': pdfUrl,
        'selectedSeats': selectedSeats,
        'vehicle': no,
        'From': FROM,
        'TO': TO,
        'Time': Time,
        'Date': date,
        'uniqueId': uniqueId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _pdfUrl = pdfUrl;
      });

      print("PDF successfully uploaded and Firestore document created");

      // Navigate to QRPage with the PDF URL
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRPage(qrData: _pdfUrl!),
        ),
      );
    } catch (e) {
      print("Error generating or uploading PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating or uploading PDF: $e')),
      );
    }
  }

  void _proceedToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => homeS(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Ticket Buyer Form',
            style: TextStyle(fontFamily: 'RobotoMono'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePdfAndUpload,
              child: Text('Generate your ticket and QR Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _proceedToPayment,
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
