import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/QRcode.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'package:jan_bahon/HomePage/lib/liveTrackMap.dart';
import 'package:jan_bahon/HomePage/lib/pdf_page.dart';
import 'package:jan_bahon/firebase_options.dart';
import 'HomePage/bus_seat_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/reg_in.dart';
import 'Screens/log_in.dart';
import 'package:animate_do/animate_do.dart';
import 'HomePage/BusOptions.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool darkModeEnabled = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(darkModeEnabled: darkModeEnabled));
}

class MyApp extends StatefulWidget {
  final bool darkModeEnabled;

  const MyApp({super.key, required this.darkModeEnabled});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool darkModeEnabled;

  @override
  void initState() {
    super.initState();
    darkModeEnabled = widget.darkModeEnabled;
  }

  void _onDarkModeChanged(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
    setState(() {
      darkModeEnabled = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => intro(),       // merge korar por add krbo .on krbo..apatoto thak
        '/home': (context) => AuthWrapper(
          darkModeEnabled: darkModeEnabled,
          onDarkModeChanged: _onDarkModeChanged,
        ), // Define your HomeScreen widget
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  const AuthWrapper(
      {required this.darkModeEnabled, required this.onDarkModeChanged});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _checkUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasData && snapshot.data != null) {
          return homeS(
            darkModeEnabled: darkModeEnabled,
            onDarkModeChanged: onDarkModeChanged,
          ); // User is logged in
        } else {
          return BottomBar(); // User is not logged in
        }
      },
    );
  }

  Future<User?> _checkUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}