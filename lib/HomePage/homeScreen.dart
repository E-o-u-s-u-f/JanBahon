import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jan_bahon/HomePage/Filter.dart';
import 'package:jan_bahon/HomePage/QRviewAuth.dart';
//import 'package:jan_bahon/HomePage/BusOptions.dart';
//import 'package:jan_bahon/HomePage/filter.dart';
//import 'package:jan_bahon/HomePage/help.dart';

import '../Screens/log_in.dart';
import 'BusOptions.dart';

import 'CarHiring.dart';
import 'Contact.dart';
import 'MapViewAuth.dart';
import 'Settings.dart';
import 'chat_screen.dart';
import 'help.dart';
import 'liveTrackMap.dart';


class homeS extends StatefulWidget {
  const homeS({super.key});

  @override
  State<homeS> createState() => _State();
}

class _State extends State<homeS> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController(text: 'Filter');

  Color textB1 = Colors.cyan;
  Color textB2 = Colors.pinkAccent;
  Color textB3 = Colors.orangeAccent;
  Color containerCol = Colors.cyan;
  Color containerCol2 = Colors.pinkAccent;
  Color containerCol3 = Colors.orangeAccent;
  int _selectedIndex = 0;
  int selInd = 0;
  String _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  Future<List<Map<String, dynamic>>> fetchBusData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Bus").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchTrainData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Train").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAirplaneData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Airplane").get();
    return qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void changeColor() {
    setState(() {
      if (containerCol == textB1) {
        containerCol == Colors.white ? Colors.cyan : Colors.white;
      } else if (containerCol2 == textB2) {
        containerCol2 == Colors.white ? Colors.pinkAccent : Colors.white;
      } else {
        containerCol3 == Colors.white ? Colors.orangeAccent : Colors.white;
      }
    });
  }
  static List<Widget> _widgetOptions1 = <Widget>[
    homeS(),
    MapviewAccessPage(),
    QRviewAccessPage(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        case 1:
          _imageUrl = 'https://images.unsplash.com/photo-1644770633699-5129770e0404?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        case 2:
          _imageUrl = 'https://images.unsplash.com/photo-1716918269977-a35b2c51f08e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
          break;
        default:
          _imageUrl = 'https://images.unsplash.com/photo-1570125909517-53cb21c89ff2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget shuttleContent = FutureBuilder(
      future: fetchBusData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var busData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10),

                    child: Center(

                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>BusOption(cur: 0)));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                    ),
                  ),
                  for (var bus in busData)
          buildBoxB(
            context,
            bus['FROM'] ?? 'Unknown',
            bus['FROM1'] ?? 'Unknown',
            bus['TO'] ?? 'Unknown',
            bus['TO1'] ?? 'Unknown',
            bus['Date'] ?? 'Unknown',
            bus['time'] ?? 'Unknown',
            bus['no'] ?? 'Unknown',
            0,
            bus['Fair']??'Unknown',
        ),
                ],
              ),
            ),
          );
        }
      },
    );

    Widget busContent = FutureBuilder(
      future: fetchTrainData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var trainData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>BusOption(cur:1)));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                    ),
                  ),
                  for (var train in trainData)
                    buildBoxB(
                      context,
                      train['FROM'],
                      train['FROM1'],
                      train['TO'],
                      train['TO1'],
                      train['Date'],
                      train['time'],
                      train['no'],
                      1,
                      train['Fair'],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );

    Widget trainContent = FutureBuilder(
      future: fetchAirplaneData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ) {
          return Center(child: Text('No data found'));
        } else {
          var airplaneData = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>BusOption(cur:2)));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                    ),
                  ),
                  for (var airplane in airplaneData)
                    buildBoxB(
                      context,
                      airplane['FROM'],
                      airplane['FROM1'],
                      airplane['TO'],
                      airplane['TO1'],
                      airplane['Date'],
                      airplane['time'],
                      airplane['no'],
                      2,
                      airplane['Fair'],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );

    List<Widget> _widgetOptions = <Widget>[
      shuttleContent,
      busContent,
      trainContent,
    ];

    return Container(
        decoration:BoxDecoration(
            gradient:LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white,Colors.indigo] )),
        child:
      Scaffold(
        backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('JanBahon',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                    color: Colors.black,
                          icon: Icon(Icons.airport_shuttle),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.train),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(1),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.transparent
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                    color: Colors.black,
                          icon: Icon(Icons.airplane_ticket),
                          iconSize: 35.0,
                          onPressed: () => _onIconTapped(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Icon(Icons.message),
        tooltip: 'Go to Chat',
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF5EFF9),
                    Color(0x00000000),
                  ],
                ),
              ),
              child: Image(
                image: AssetImage('assets/JanBahon-removebg-preview.png'),
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Map'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LiveTracking()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .9)),
              ),
              child: ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  settingsScreen()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Help'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Contact'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
                },
              ),
            ),Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Car Hiring'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HiringCars()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Log out'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera,color: Colors.black),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2,color: Colors.black),
            label: 'QR Code',
          ),
        ],
        currentIndex: selInd,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedLabelStyle:TextStyle(fontWeight: FontWeight.bold) ,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          setState(() {
            selInd = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _widgetOptions1[index]),
          );
        },
      ),
    ));
  }

}
