import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'package:jan_bahon/firebase_options.dart';
//import 'package:jan_bahon/splashscreen.dart';
import 'Screens/reg_in.dart';
import 'Screens/log_in.dart';
import 'package:animate_do/animate_do.dart';
import 'HomePage/BusOptions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      ),
      initialRoute: '/',
      routes: {
        //'/': (context) => intro(),       // merge korar por add krbo .on krbo..apatoto thak


        '/home': (context) => AuthWrapper(), // Define your HomeScreen widget
      },
    );
  }

}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _checkUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasData && snapshot.data != null) {
          return homeS(); // User is logged in
        } else {
          return regScreen(); // User is not logged in
        }
      },
    );
  }

  Future<User?> _checkUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}


