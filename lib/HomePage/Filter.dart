import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bus_seat_selection.dart';

class BusOption extends StatefulWidget {
  final int cur;

  const BusOption({super.key, required this.cur});

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
            title: const  Text(
                'Search',
                style: TextStyle(fontFamily: 'RobotoMono'),
              ),
            centerTitle: true,
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
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
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
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
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (selectedFrom == null ||
                      selectedTo == null ||
                      selectedDate == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please select all fields'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
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
                        .collection(widget.cur == 0
                        ? "Bus"
                        : widget.cur == 1
                        ? "Train"
                        : "Airplane")
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
                            title: const Text('Sorry'),
                            content: const Text(
                                'No options found for the selected criteria.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
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
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : const Text('Search'),
              ),
              const SizedBox(height: 16.0),
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
                    widget.cur,
                    option["Fair"]!,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildBoxB(
      BuildContext context,
      String FROM,
      String FROM1,
      String TO,
      String TO1,
      String date,
      String time,
      String no,
      int cur,
      String money,
      ) {
    String description = "";
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
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
            const SizedBox(height: 16.0),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date', style: TextStyle(color: Colors.grey)),
                      Text(date),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Fare', style: const TextStyle(color: Colors.grey)),
                      Text('$money TK'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Time', style: TextStyle(color: Colors.grey)),
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
}
