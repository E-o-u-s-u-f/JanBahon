import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'BusOptions.dart';
import 'bus_seat_selection.dart';

class BusOption extends StatefulWidget {
  const BusOption({super.key});

  @override
  State<BusOption> createState() => _BusOptionState();
}

class _BusOptionState extends State<BusOption> {
  String? selectedFrom;
  String? selectedTo;
  String? formattedDate;
  DateTime? selectedDate;

  final List<String> locations = [
    'Dhaka',
    'Rajshahi',
    'Khulna',
    'Faridpur',
    'Munshiganj',
    'Chittagong',
    'Rangpur',
    'Sylhet'
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  bool noBusFound = false;
  bool isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 3, top: 50),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
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
                    selectedTo =
                    null; // Reset selectedTo when selectedFrom changes
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
                items: locations
                    .where((location) => location != selectedFrom)
                    .map((String location) {
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
                readOnly: true,
                onTap: () => _selectDate(context),
                controller: TextEditingController(
                  text: selectedDate == null
                      ? ''
                      : '${selectedDate!.day}/${selectedDate!
                      .month}/${selectedDate!.year}',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (selectedFrom == null ||
                      selectedTo == null ||
                      selectedDate == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please select all fields'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  try {
                    formattedDate =
                        DateFormat('MM/dd/yyyy').format(selectedDate!);
                    print(
                        'Searching from $selectedFrom to $selectedTo on $formattedDate');

                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection("Bus")
                        .where('Date', isEqualTo: formattedDate)
                        .where('FROM1', isEqualTo: selectedFrom)
                        .where('TO1', isEqualTo: selectedTo)
                        .get();

                    setState(() {
                      filteredOptions = querySnapshot.docs.map((doc) {
                        return {
                          "FROM": doc['FROM'],
                          "FROM1": doc['FROM1'],
                          "TO": doc['TO'],
                          "TO1": doc['TO1'],
                          "Date": doc['Date'],
                          "time": doc['time'],
                          "no": doc['no'],
                          "location": doc['location'],
                          "Fair": doc['Fair'],
                        };
                      }).toList();

                      noBusFound = filteredOptions.isEmpty;
                    });

                    if (noBusFound) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sorry'),
                            content: Text(
                                'No bus found for the selected criteria.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    print('Filtered Options: $filteredOptions');
                  } catch (e) {
                    print('Error fetching data: $e');
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text('Search'),
              ),
              SizedBox(height: 16.0),
              Column(
                children: filteredOptions.map((option) {
                  return buildBoxB(
                      context,
                      option["FROM"]!,
                      option["FROM1"]!,
                      option["TO"]!,
                      option["TO1"]!,
                      option["Date"]!,
                      option["time"]!,
                      option["no"]!,
                      0,
                      option["Fair"]!
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}