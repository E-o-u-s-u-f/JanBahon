import 'package:flutter/material.dart';
class intro extends StatefulWidget {
  const intro({super.key});

  @override
  State<intro> createState() => _introState();
}


class _introState extends State<intro> {


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/J.gif'),
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
      ),
    );
  }
}




