import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PaymentOption.dart';

class PaymentOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Option"),
      ),
      body: Center(
        child: Text("Payment Option Page"),
      ),
    );
  }
}

class BusSeatSelection extends StatefulWidget {
  final String FROM;
  final String TO;
  final String Time;
  final String date;
  final String no;
  final String description;
  final String Fair;

  BusSeatSelection({
    required this.FROM,
    required this.TO,
    required this.Time,
    required this.date,
    required this.no,
    required this.description,
    required this.Fair
  });

  @override
  State<BusSeatSelection> createState() => _BusSeatSelectionState();
}

class _BusSeatSelectionState extends State<BusSeatSelection> {
  Set<int> _selectedSeats = {};
  bool _isAnySeatSelected = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<int> _reservedSeats = [];
  String? _documentId;
  int _totalPayment = 0;
  late int seatPrice;

  @override
  void initState() {
    super.initState();
    print("FROM: ${widget.FROM}");
    print("TO: ${widget.TO}");
    print("Time: ${widget.Time}");
    print("Date: ${widget.date}");
    print("Number: ${widget.no}");
    print("Description: ${widget.description}");

    seatPrice = int.parse(widget.Fair);
    _fetchReservedSeats();
  }

  Future<void> _fetchReservedSeats() async {
    if (kDebugMode) {
      print('entered fetchReserved');
    }
    QuerySnapshot querySnapshot = await _firestore
        .collection(_getCollectionName())
        .where('FROM', isEqualTo: widget.FROM)
        .where('TO', isEqualTo: widget.TO)
        .where('Time', isEqualTo: widget.Time)
        .where('date', isEqualTo: widget.date)
        .where('no', isEqualTo: widget.no)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (kDebugMode) {
        print("Document ID: ${doc.id}");
      }
      if (kDebugMode) {
        print("FROM: ${data['FROM']}");
      }
      if (kDebugMode) {
        print("TO: ${data['TO']}");
      }
      if (kDebugMode) {
        print("Time: ${data['Time']}");
      }
      if (kDebugMode) {
        print("Date: ${data['date']}");
      }
      if (kDebugMode) {
        print("No: ${data['no']}");
      }
      if (kDebugMode) {
        print("---------");
      } // Separator between documents
    }

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      setState(() {
        _documentId = doc.id;
      });
      if (kDebugMode) {
        print(_documentId);
      }

      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('reservedSeats')) {
        setState(() {
          _reservedSeats = List<int>.from(data['reservedSeats']);
        });
        if (kDebugMode) {
          print("Reserved Seats: ${_reservedSeats.toList()}");
        }
      }
    }
  }

  Future<void> _reserveSeats() async {
    if (kDebugMode) {
      print('entered Reserved');
    }
    final user = _auth.currentUser;
    if (user != null) {
      WriteBatch batch = _firestore.batch();
      DocumentReference userRef = _firestore.collection("users").doc(user.uid);
      batch.set(userRef, {
        'reservedSeats': _selectedSeats.toList(),
      }, SetOptions(merge: true));
      if (_documentId != null) {
        DocumentReference transportRef = _firestore.collection(_getCollectionName()).doc(_documentId!);
        batch.update(transportRef, {
          'reservedSeats': FieldValue.arrayUnion(_selectedSeats.toList()),
        });
      } else {
        DocumentReference newTransportRef = _firestore.collection(_getCollectionName()).doc();
        batch.set(newTransportRef, {
          'FROM': widget.FROM,
          'TO': widget.TO,
          'Time': widget.Time,
          'date': widget.date,
          'no': widget.no,
          'reservedSeats': _selectedSeats.toList(),
        });
      }

      // Commit the batch
      await batch.commit();
    }
  }

  String _getCollectionName() {
    switch (widget.description) {
      case "Train":
        return "TrainSeats";
      case "Airplane":
        return "AirplaneSeats";
      default:
        return "BusSeats";
    }
  }

  Widget _seatLayout(int seatNumber) {
    switch (widget.description) {
      case "Train":
        return _trainSeatLayout(seatNumber);
      case "Airplane":
        return _airplaneSeatLayout(seatNumber);
      default:
        return _busSeatLayout(seatNumber);
    }
  }

  Widget _busSeatLayout(int seatNumber) {
    final bool isSelected = _selectedSeats.contains(seatNumber);
    final bool isReserved = _reservedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: !isReserved
          ? () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatNumber);
            _totalPayment -= seatPrice;
          } else {
            _selectedSeats.add(seatNumber);
            _totalPayment += seatPrice;
          }
          _isAnySeatSelected = _selectedSeats.isNotEmpty;
        });
        print("Selected Seats: ${_selectedSeats.toList()}");
      }
          : null,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: isReserved
              ? Colors.lightBlue.shade900
              : isSelected
              ? Colors.lightBlue.shade400
              : Colors.white,
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: isReserved ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _trainSeatLayout(int seatNumber) {
    final bool isSelected = _selectedSeats.contains(seatNumber);
    final bool isReserved = _reservedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: !isReserved
          ? () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatNumber);
            _totalPayment -= seatPrice;
          } else {
            _selectedSeats.add(seatNumber);
            _totalPayment += seatPrice;
          }
          _isAnySeatSelected = _selectedSeats.isNotEmpty;
        });
        print("Selected Seats: ${_selectedSeats.toList()}");
      }
          : null,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: isReserved
              ? Colors.lightBlue.shade900
              : isSelected
              ? Colors.lightBlue.shade400
              : Colors.white,
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: isReserved ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _airplaneSeatLayout(int seatNumber) {
    final bool isSelected = _selectedSeats.contains(seatNumber);
    final bool isReserved = _reservedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: !isReserved
          ? () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatNumber);
            _totalPayment -= seatPrice;
          } else {
            _selectedSeats.add(seatNumber);
            _totalPayment += seatPrice;
          }
          _isAnySeatSelected = _selectedSeats.isNotEmpty;
        });
        print("Selected Seats: ${_selectedSeats.toList()}");
      }
          : null,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: isReserved
              ? Colors.lightBlue.shade900
              : isSelected
              ? Colors.lightBlue.shade400
              : Colors.white,
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: isReserved ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
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
        centerTitle: true,
        title: const Text("Select seat",style:TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade900,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text("Booked"),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
                Text("Vacant"),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (widget.description == "Bus")
                  ..._busLayout(),
                if (widget.description == "Train")
                  ..._trainLayout(),
                if (widget.description == "Airplane")
                  ..._airplaneLayout(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Seat: ${_selectedSeats.length}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 130),
                    Text(
                      "Total Payment: \$${_totalPayment.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _isAnySeatSelected
                        ? () async {
                      await _reserveSeats();
                      setState(() {
                        _reservedSeats.addAll(_selectedSeats);
                        _selectedSeats.clear();
                        _isAnySeatSelected = false;
                        _totalPayment = 0;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(
                            totalPayment: _totalPayment,
                            selectedSeats: _selectedSeats,
                            FROM: widget.FROM,
                            TO: widget.TO,
                            Time: widget.Time,
                            date: widget.date,
                            no: widget.no,
                            description: widget.description,
                          ),
                        ),
                      );
                    }
                        : null,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        color: _isAnySeatSelected ? Colors.lightBlue.shade900: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: _isAnySeatSelected
                              ? () async {
                            await _reserveSeats();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment(
                                  totalPayment: _totalPayment,
                                  selectedSeats: _selectedSeats,
                                  FROM: widget.FROM,
                                  TO: widget.TO,
                                  Time: widget.Time,
                                  date: widget.date,
                                  no: widget.no,
                                  description: widget.description,
                                ),
                              ),
                            );
                          }
                              : null,
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  List<Widget> _busLayout() {
    return [
      Positioned(
        top: 10,
        left: 60,
        child: Card(
          color: Colors.transparent,
          elevation: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child:
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i < 9; i++)
                  Row(
                    children: [
                      for (int j = 0; j < 2; j++)
                        _seatLayout(i * 4 + j + 1),
                      SizedBox(
                        width: 47,
                      ),
                      for (int j = 2; j < 4; j++)
                        _seatLayout(i * 4 + j + 1),
                    ],
                  ),
                Row(
                  children: [
                    _seatLayout(37),
                    _seatLayout(38),
                    _seatLayout(39), // Extra seat in the gap
                    _seatLayout(40),
                    _seatLayout(41),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _trainLayout() {
    return [
      Positioned(
        top: 10,
        left: 50,
        child: Card(
          color: Colors.transparent,
          elevation: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child:
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i <= 9; i++)
                  Row(
                    children: [
                      for (int j = 0; j < 2; j++)
                        _seatLayout(i * 5 + j + 1),
                      SizedBox(
                        width: 20,
                      ),
                      for (int j = 2; j <= 4; j++)
                        _seatLayout(i * 5 + j + 1),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _airplaneLayout() {
    return [
      Positioned(
        top: 10,
        left: 50,
        child: Card(
          color: Colors.transparent,
          elevation: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child:
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i <= 9; i++)
                  Row(
                    children: [
                      for (int j = 0; j < 2; j++)
                        _seatLayout(i * 5 + j + 1),
                      SizedBox(
                        width: 20,
                      ),
                      for (int j = 2; j <= 4; j++)
                        _seatLayout(i * 5 + j + 1),
                    ],
                  ),
              ],
            ),
          ),
          
        ),
      ),
    ];
  }
}
