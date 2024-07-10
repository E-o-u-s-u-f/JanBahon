import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'PaymentOption.dart';
import 'pdf_page.dart';

class BusSeatSelection extends StatefulWidget {
  final String FROM;
  final String TO;
  final String Time;
  final String date;
  final String no;
  final String description;

  BusSeatSelection({
    required this.FROM,
    required this.TO,
    required this.Time,
    required this.date,
    required this.no,
    required this.description,
  });

  @override
  State<BusSeatSelection> createState() => _BusSeatSelectionState();
}

class _BusSeatSelectionState extends State<BusSeatSelection> {
  final Set<int> _selectedSeats = {};
  bool _isAnySeatSelected = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<int> _reservedSeats = [];
  String? _documentId;
  double _totalPayment = 0.0;
  final double seatPrice = 1000.0;

  @override
  void initState() {
    super.initState();
    _fetchReservedSeats();
  }

  Future<void> _fetchReservedSeats() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(widget.description)
        .where('FROM', isEqualTo: widget.FROM)
        .where('TO', isEqualTo: widget.TO)
        .where('Time', isEqualTo: widget.Time)
        .where('date', isEqualTo: widget.date)
        .where('no', isEqualTo: widget.no)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      setState(() {
        _documentId = doc.id;
      });

      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('reservedSeats')) {
        setState(() {
          _reservedSeats = List<int>.from(data['reservedSeats']);
        });
      }
    }
  }

  Future<void> _reserveSeats() async {
    final user = _auth.currentUser;
    if (user != null) {
      WriteBatch batch = _firestore.batch();

      // Update user document with reserved seats
      DocumentReference userRef = _firestore.collection('Users').doc(user.uid);
      batch.set(userRef, {
        'reservedSeats': _selectedSeats.toList(),
      }, SetOptions(merge: true));

      // Update transport document with reserved seats
      if (_documentId != null) {
        DocumentReference transportRef = _firestore.collection(widget.description).doc(_documentId);
        batch.update(transportRef, {
          'reservedSeats': FieldValue.arrayUnion(_selectedSeats.toList()),
        });

        // Commit the batch
        await batch.commit();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Select seat"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.grey[200],
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
                      color: Colors.green,
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
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                  Text("Vacant"),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 60,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
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
                            // Last row with an extra seat in the gap
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 130,
          child: BottomAppBar(
            elevation: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Seat: ${_selectedSeats.length}/41",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 120,
                      ),
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
                          _totalPayment = 0.0;
                        });
                      }
                          : null,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: _isAnySeatSelected ? Colors.red : Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: _isAnySeatSelected
                                ? () {
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => Payment(
                                    totalPayment: _selectedSeats.length * 1000.0,
                                    selectedSeats: _selectedSeats,
                                    FROM: widget.FROM,
                                    TO: widget.TO,
                                    Time: widget.Time,
                                    date: widget.date,
                                    no: widget.no,
                                    description: widget.description,
                                  ),
                                ),
                              );*/
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
        ));
  }

  Widget _seatLayout(int seatNumber) {
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
      }
          : null,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: isReserved
              ? Colors.green
              : isSelected
              ? Colors.lightGreenAccent
              : Colors.white,
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: isReserved
                  ? Colors.white
                  : isSelected
                  ? Colors.black
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
