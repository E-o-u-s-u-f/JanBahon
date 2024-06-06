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
      body: Center(
        child: Image.asset('assets/J.gif'), // Your splash screen image
      ),
    );
  }
}




