import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jan_bahon/HomePage/liveTrackMap.dart';

import 'QRcode.dart';

class MapviewAccessPage extends StatefulWidget {
  @override
  _MapviewAccessPageState createState() => _MapviewAccessPageState();
}

class _MapviewAccessPageState extends State<MapviewAccessPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _pdfUrl;
  String? _errorMessage;

  Future<void> _searchDocument() async {
    final searchString = _searchController.text;

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uniqueId', isEqualTo: searchString)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _errorMessage = null;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveTracking(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'No match found. Please check the input.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      print('Error fetching data: $e'); // Log the error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Access Your MAP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Pass Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchDocument,
              child: Text('Search'),
            ),
            SizedBox(height: 10),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
