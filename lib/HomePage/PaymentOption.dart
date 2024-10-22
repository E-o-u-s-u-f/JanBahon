import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'package:jan_bahon/HomePage/pdf_page.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Payment extends StatefulWidget {
  final int totalPayment;
  final Set<int> selectedSeats;
  final String FROM;
  final String TO;
  final String Time;
  final String date;
  final String no;
  final String description;

  Payment({
    required this.totalPayment,
    required this.selectedSeats,
    required this.FROM,
    required this.TO,
    required this.Time,
    required this.date,
    required this.no,
    required this.description,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _loading = false;
  String? _selectedPaymentMethod = 'Credit Card';
  bool _isSwiped = false;

  void _processPayment() {
    // Check if card number is empty
    if (_selectedPaymentMethod == 'Credit Card' && _cardNumberController.text.isEmpty) {
      _showErrorDialog("Card number cannot be empty.");
      return;
    }

    setState(() {
      _loading = true;
    });

    // Replace with actual payment processing logic
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading = false;
        _cardNumberController.clear();
        _expiryDateController.clear();
        _cvvController.clear();
        _showPaymentSuccessDialog();
      });
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
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

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Success'),
          content: Text('Your payment of \$${widget.totalPayment.toStringAsFixed(2)} was successfully processed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PDFPage(
                  selectedSeats: widget.selectedSeats,
                  FROM: widget.FROM,
                  TO: widget.TO,
                  Time: widget.Time,
                  date: widget.date,
                  no: widget.no,
                  description: widget.description,
                ),));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreditCardForm() {
    return Column(
      children: [
        TextFormField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Card Number',
            prefixIcon: Icon(Icons.credit_card),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(String method) {
    return ListTile(
      title: Text(method),
      leading: Radio<String>(
        value: method,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? value) {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
      ),
    );
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Payment Page'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              const Center(
                child: Text(
                  'Enter Your Payment Details',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                'Total Payment: \$${widget.totalPayment.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              _buildPaymentMethodOption('Credit Card'),
              _buildPaymentMethodOption('Google Pay'),
              _buildPaymentMethodOption('PayPal'),
              SizedBox(height: 16.0),
              if (_selectedPaymentMethod == 'Credit Card') _buildCreditCardForm(),
              if (_selectedPaymentMethod == 'Google Pay')
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Redirecting to Google Pay...',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
              if (_selectedPaymentMethod == 'PayPal')
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Redirecting to PayPal...',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
              SizedBox(height: 24.0),
              SlideAction(
                sliderButtonIcon: const Icon(
                  Icons.payment_outlined,
                  color: Colors.indigo,
                ),
                text: 'Swipe to Pay',
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                innerColor: Colors.white,
                outerColor: Colors.indigoAccent,
                onSubmit: () {
                  _processPayment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
