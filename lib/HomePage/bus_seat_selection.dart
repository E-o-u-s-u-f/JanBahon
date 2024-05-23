import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusSeatSelection extends StatefulWidget {
  const BusSeatSelection({super.key});

  @override
  State<BusSeatSelection> createState() => _BusSeatSelectionState();
}

class _BusSeatSelectionState extends State<BusSeatSelection> {
  // State to keep track of selected seats
  final Set<int> _selectedSeats = {};
  bool _isAnySeatSelected = false; // Track if any seat is selected

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
                  top: 50,
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
                                  _seatLayout(i * 4 + j),
                                SizedBox(
                                  width: 47,
                                ),
                                for (int j = 2; j < 4; j++)
                                  _seatLayout(i * 4 + j),
                              ],
                            ),
                          // Last row with an extra seat in the gap
                          Row(
                            children: [
                              _seatLayout(36),
                              _seatLayout(37),
                              _seatLayout(38), // Extra seat in the gap
                              _seatLayout(39),
                              _seatLayout(40),
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
        height: 84,
        child: BottomAppBar(
          elevation: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text("Seat: ${_selectedSeats.length}/41"),
                // Updated total seat count
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: _isAnySeatSelected ? Colors.red : Colors.amberAccent,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _seatLayout(int index) {
    final bool isSelected = _selectedSeats.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(index);
          } else {
            _selectedSeats.add(index);
          }

          _isAnySeatSelected =
              _selectedSeats.isNotEmpty;
        });
      },
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
          color: isSelected ? Colors.lightGreenAccent : Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              bottom: 5,
              left: 5,
              right: 5,
              child: SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? Colors.lightGreenAccent : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 29,
              bottom: 5,
              left: 5,
              right: 5,
              child: SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? Colors.lightGreenAccent : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              bottom: 5,
              left: 4,
              right: 30,
              child: SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? Colors.lightGreenAccent : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              bottom: 5,
              left: 30,
              right: 4,
              child: SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: isSelected ? Colors.lightGreenAccent : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}