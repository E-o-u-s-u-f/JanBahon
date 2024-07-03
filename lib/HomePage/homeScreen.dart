import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jan_bahon/HomePage/filter.dart';
import '../Screens/log_in.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:jan_bahon/HomePage/lib/trainOption.dart';
import 'package:jan_bahon/Seat&BuyTicket/bus_seat_selection.dart';
import '../Screens/contact.dart';
import '../Screens/help.dart';
import '../Screens/settting.dart';
import 'BusOptions.dart';
import 'lib/liveTrackMap.dart';

class homeS extends StatefulWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

   homeS({
    Key? key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  State<homeS> createState() => _State();
}

class _State extends State<homeS> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller=TextEditingController(text: 'Filter');
  bool _darkModeEnabled = false;

  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    hintColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    iconTheme: IconThemeData(
      color: Colors.red,
    ),
  );

  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    hintColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
  );

  Color  textB1=Colors.cyan;
  Color textB2=Colors.pinkAccent;
  Color  textB3=Colors.orangeAccent;
  Color containerCol=Colors.cyan;
  Color containerCol2=Colors.pinkAccent;
  Color containerCol3=Colors.orangeAccent;
  int _selectedIndex=0;
  int selInd=0;
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

  void _toggleDarkMode() {
    setState(() {
      _darkModeEnabled = !_darkModeEnabled; // Toggle the state
    });
    widget.onDarkModeChanged(_darkModeEnabled); // Notify parent widget
  }
 static List<Widget> _widgetOptions1 = <Widget>[
    homeS(),
    LiveTracking(),
   // QrCode(),

  ];
  void _onItemTapped(int index1) {
    setState(() {
      selInd = index1;
    });
  }
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
    ThemeData currentTheme = widget.darkModeEnabled ? _darkTheme : _lightTheme;

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
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Filtered()));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ),
                    ),
                  ),
                  for (var bus in busData)
                    buildBoxB(
                      context,
                      bus['FROM'],
                      bus['FROM1'],
                      bus['TO'],
                      bus['TO1'],
                      bus['Date'],
                      bus['time'],
                      bus['no'],
                      _selectedIndex,
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Filtered()));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18, color: Colors.black12)),
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
                      _selectedIndex,
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(_imageUrl),
                  ),
                  Container(
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Filtered()));
                        },
                        child: const Text('Click here to search', style: TextStyle(fontSize: 18, color: Colors.grey)),
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
                      _selectedIndex,
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
     /* homeS(),
      //MapS(),
      // QrCode(),*/
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('JanBahon',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor:currentTheme.appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onIconTapped(0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF737171),
                            Color(0xFFFDF9FD),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.airport_shuttle,
                            size: 35.0,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onIconTapped(1),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF737171),
                            Color(0xFFFDF9FD),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.train,
                            size: 35.0,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2,),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onIconTapped(2),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF737171),
                            Color(0xFFFDF9FD),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.airplane_ticket,
                            size: 35.0,
                            color:Theme.of(context).iconTheme.color,
                            //currentTheme.iconTheme.color,
                          ),
                        ],
                      ),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.darkModeEnabled
                      ? [
                    Color(0xF3F3F3F3),
                    Color(0xFFF5EFF9),
                  ]
                      : [
                    Color(0xFFF5EFF9),
                    Color(0x00000000),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
                border: Border(bottom: BorderSide(color: Colors.grey, width: .9)),
              ),
              child: ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settingsScreen(
                      darkModeEnabled: widget.darkModeEnabled,
                      onDarkModeChanged: widget.onDarkModeChanged,
                    )),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: .9)),
              ),
              child: ListTile(
                title: Text('Help'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage(
                       darkModeEnabled: widget.darkModeEnabled,
                      onDarkModeChanged: widget.onDarkModeChanged,
                    )),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: .8)),
              ),
              child: ListTile(
                title: Text('Contact'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage(
                      darkModeEnabled: widget.darkModeEnabled,
                      onDarkModeChanged: widget.onDarkModeChanged,
                    )),
                  );
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'QR code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Map',
          ),
        ],
        currentIndex: selInd,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
