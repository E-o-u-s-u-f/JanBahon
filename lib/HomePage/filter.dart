import 'package:flutter/material.dart';

class Filtered extends StatefulWidget {
  const Filtered({super.key});

  @override
  State<Filtered> createState() => _FilterState();
}

class _FilterState extends State<Filtered> {
  String? selectedFrom;
  String? selectedTo;

  final List<String> locations = [
    'Dhaka',
    'Rajshahi',
    'Khulna',
    'Chittagang',
    'Rangpur',
    'Sylhet'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 3, top: 130),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            SizedBox(height: 40),
            SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white54,
                      filled: true,
                      labelText: 'From:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    value: selectedFrom,
                    items: locations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFrom = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white54,
                      filled: true,
                      labelText: 'To:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    value: selectedTo,
                    items: locations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTo = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white54,
                      filled: true,
                      labelText: 'Date:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implement search logic here
                      print('Searching from $selectedFrom to $selectedTo');

                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
