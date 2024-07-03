import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'package:jan_bahon/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/reg_in.dart';
import 'Screens/log_in.dart';
import 'package:animate_do/animate_do.dart';
import 'HomePage/BusOptions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool darkModeEnabled = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(darkModeEnabled: darkModeEnabled));
}
class MyApp extends StatefulWidget {
  final bool darkModeEnabled;

   MyApp({super.key, required this.darkModeEnabled});

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
      home: homeS(
        darkModeEnabled: darkModeEnabled,
        onDarkModeChanged: _onDarkModeChanged,
      ),
    );
  }
}

/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jan_bahon/HomePage/homeScreen.dart';
import 'package:jan_bahon/firebase_options.dart';
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
        useMaterial3: true,
      ),
      home:  homeS(),
    );
  }
}

*/
