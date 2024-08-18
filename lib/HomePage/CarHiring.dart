import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HiringCars extends StatefulWidget {
  HiringCars({super.key});

  @override
  _HiringCarsState createState() => _HiringCarsState();
}

class _HiringCarsState extends State<HiringCars> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nidController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();

  void _showHiringSuccessfulDialog() {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submission Successful'),
          content: Text('Your data has been submitted successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nameController.clear();
                _nidController.clear();
                _phoneController.clear();
                _fromController.clear();
                _toController.clear();
                _timeController.clear();
                _dateController.clear();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      try {

        final FirebaseFirestore _firestore = FirebaseFirestore.instance;

        // Get values from controllers
        final name = _nameController.text;
        final nid = _nidController.text;
        final phone = _phoneController.text;
        final from = _fromController.text;
        final to = _toController.text;
        final time = _timeController.text;
        final date = _dateController.text;


        await _firestore.collection('hiringRequests').add({
          'name': name,
          'nid': nid,
          'phone': phone,
          'from': from,
          'to': to,
          'time': time,
          'date': date,
        });


        _showHiringSuccessfulDialog();
      } catch (e) {
        print('Error submitting data: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting data: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nidController.dispose();
    _phoneController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
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
        title: Text('Hiring Cars'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nidController,
                decoration: InputDecoration(
                  labelText: 'NID No',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your NID number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone No',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fromController,
                decoration: InputDecoration(
                  labelText: 'From',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the from location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _toController,
                decoration: InputDecoration(
                  labelText: 'To',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the to location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateController.text = "${picked.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
