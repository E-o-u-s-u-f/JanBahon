import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'BusOptions.dart';

class BusOption extends StatefulWidget {
  final int cur;
  BusOption({super.key, required this.cur});

  @override
  State<BusOption> createState() => _BusOptionState();
}

class _BusOptionState extends State<BusOption> {
  String? selectedFrom;
  String? selectedTo;
  String? formattedDate;
  DateTime? selectedDate;
  late int cur;

  final List<String> locations = [
    'Dhaka',
    'Rajshahi',
    'Khulna',
    'Faridpur',
    'Munshiganj',
    'Chittagong',
    'Rangpur',
    'Sylhet',
    'Barishal',
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  bool noBusFound = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    cur = widget.cur;
    print('Current mode (cur value): $cur'); // Debugging
  }

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

  String getCollectionName(int cur) {
    switch (cur) {
      case 0:
        return "Bus";
      case 1:
        return "Train";
      case 2:
        return "Airplane";
      default:
        return "Bus"; // Default to "Bus" if cur is out of expected range
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.indigo],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'JanBahon',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 10),
              Icon(Icons.search, color: Colors.indigo),
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                      selectedTo = null; // Reset selectedTo when selectedFrom changes
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
                      borderRadius: BorderRadius.circular(35),
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
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}', // Corrected date format
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
                          DateFormat('dd/MM/yyyy').format(selectedDate!);
                      print(
                          'Searching from $selectedFrom to $selectedTo on $formattedDate');

                      String collectionName = getCollectionName(cur);
                      print('Selected collection: $collectionName'); // Debugging

                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection(collectionName)
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
                                  'No vehicle found for the selected criteria.'),
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
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
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
                      cur,
                      option["Fair"],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
