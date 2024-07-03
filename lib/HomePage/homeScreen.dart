import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:jan_bahon/HomePage/lib/trainOption.dart';
import 'package:jan_bahon/Seat&BuyTicket/bus_seat_selection.dart';
import '../Screens/contact.dart';
import '../Screens/help.dart';
import '../Screens/settting.dart';
import 'BusOptions.dart';
import 'lib/Screens/log_in.dart';
import 'lib/Seat&BuyTicket/bus_seat_selection.dart';

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


  void changeColor(){
    setState(() {
      if(containerCol==textB1) {
        containerCol == Colors.white ? Colors.cyan : Colors.white;
      }else if(containerCol2==textB2){
        containerCol2== Colors.white ? Colors.pinkAccent : Colors.white;
      }else{
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
 /*static List<Widget> _widgetOptions1 = <Widget>[
    homeS(),
    //MapS(),
   // QrCode(),
  ];*/
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

    Widget shuttleContent = SingleChildScrollView(
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
                child: CupertinoSearchTextField(
                  controller: _controller,
                ),
              ),
            ),
            buildBoxB(context, "DHA", "Dhaka", "CHA", "Chittagong", "06-06-2024", "02:35 am", "BU1234"),
            buildBoxB(context, "RAN", "Rangpur", "RAJ", "Rajshahi", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "CHA", "Chittagong", "RAJ", "Rajshahi", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "MYN", "Mymensingh", "DHA", "Dhaka", "06-06-2024", "07:35 am", "UB1234"),
            buildBoxB(context, "MYN", "Mymensingh", "RAN", "Rangpur", "06-06-2024", "04:35 am", "UB1234"),
            buildBoxB(context, "SYL", "Sylhet", "DHA", "Dhaka", "06-06-2024", "07:35 am", "UB1234"),
          ],
        ),
      ),
    );

    Widget busContent = SingleChildScrollView(
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
                child: CupertinoSearchTextField(
                  controller: _controller,
                ),
              ),
            ),
            buildBoxTrain(context, "SYL", "Sylhet", "KHU", "Khulna", "23-05-2024", "06:35 am", "UL1234"),
            buildBoxTrain(context, "BAR", "Barisal", "MYM", "Mymensingh", "23-05-2024", "09:35", "KL0464"),
            buildBoxTrain(context, "DHA", "Dhaka", "MYM", "Mymensingh", "23-05-2024", "03:35", "FL0584"),
            buildBoxTrain(context, "CHA", "Chittagong", "MYM", "Mymensingh", "23-05-2024", "09:35", "KL0564"),
            buildBoxTrain(context, "RAN", "Rangpur", "MYM", "Mymensingh", "23-05-2024", "03:35", "TL0564"),
            buildBoxTrain(context, "DHA", "Dhaka", "RAJ", "Rajshahi", "23-05-2024", "09:35", "PL0964"),
          ],
        ),
      ),
    );

    Widget trainContent = SingleChildScrollView(
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
                child: CupertinoSearchTextField(
                  controller: _controller,
                ),
              ),
            ),
            buildBoxB(context, "FAR", "Faridpur", "MUN", "Munshiganj", "24-05-2024", "12:00 am", "NI4207"),
            buildBoxB(context, "RAJ", "Rajshahi", "DHA", "Dhaka", "24-05-2024", "02:35 am", "JO2454"),
          ],
        ),
      ),
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
       // mainAxisAlignment: MainAxisAlignment.start,
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
                border: Border(bottom: BorderSide(color: Colors.grey,width: .9)),
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
                border: Border(bottom: BorderSide(color: Colors.grey,width: .8)),
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
                border: Border(bottom: BorderSide(color: Colors.grey,width: .8)),
              ),
              child: ListTile(
                title: Text('Log out'),
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomAppBar()));
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