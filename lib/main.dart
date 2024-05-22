import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'Screens/reg_in.dart';
import 'Screens/log_in.dart';
import 'package:animate_do/animate_do.dart';
import 'Screens/BusOptions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home:  BottomBar(),
    );
  }
}


